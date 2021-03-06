class BooksController < ApplicationController
  before_action :find_book, only: :show

  def index
    @books = Book.all
  end

  def show
     @user_book = UserBook.new
     # have_read = params[:range][:start].to_time.beginning_of_month if params[:range]
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to books_path
    else
      render :new
    end
  end

  def create
    @book = Book.new(book_params)
    find_google_book
    @google_book == nil ? cannot_find : assign_values
    if @book.save
      create_user_book
      redirect_to book_path(@book) and return
    else
      redirect_to new_book_path and return
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def create_user_book
    @user_book = UserBook.new
    @user_book.user = current_user
    @user_book.book = @book
    @user_book.have_read = params[:book][:user_book_attributes]["have_read"]
    @user_book.save
  end

  private

  def find_google_book
    find_books.each do |book| #google book ingnore the catogary search term so this ensure a fiction novel
      @google_book = book
      break if book.categories == "Fiction"
    end
  end

  def find_books
    search_terms = "inauthor:#{@book.author}, intitle:#{@book.title}, subject: 'Fiction' "
    GoogleBooks.search(search_terms)
  end

  def cannot_find
    flash.notice = "Couldn't find you're book, please try again."
    redirect_to new_book_path
  end

  # Note - Search terms changed to google books results to avoid duplication due to miss spelling
  def assign_values
    @book.title = @google_book.title
    @book.author = @google_book.authors
    @book = Book.where(title: @book.title, author: @book.author).first_or_create do |book|
      book.photo_url = @google_book.image_link
      book.description = @google_book.description
      book.page_count = @google_book.page_count
      book.isbn = @google_book.isbn
    end
  end

  def book_params
    params.require(:book).permit(:title, :author, user_books_attributes: [:id, :have_read] )
  end

  def find_book
    @book = Book.find(params[:id])
  end
end
