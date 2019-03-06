class BooksController < ApplicationController
  before_action :find_book, only: :show

  def index
    @books = Book.all
  end

  def show
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

    #search_terms varible made as GoogleBooks.search won't except variables
    search_terms = "inauthor:#{@book.author}, intitle:#{@book.title}, subject: 'Fiction' "
    title = @book.title
    google_books_objects = GoogleBooks.search(search_terms)

    #Google books tends to ingnore subject so this removes non fiction
    google_books = []
    google_books_objects.each do |book|
      if book.categories == "Fiction"
        google_books << book
      end
    end

    if google_books.empty?
      flash.notice = "Couldn't find you're book, please try again."
      redirect_to new_book_path
    else

    first_book = google_books.first

    first_book.image_link(:zoom => 6)
    # title and autors changed from search terms to prevent duplication. ie having Tolkien and J R Tolkien being differant authors
    @book.title = first_book.title
    @book.author = first_book.authors
    #Finf the book if it exists with the same title and author, if not creates it.
    @book = Book.where(title: @book.title, author: @book.author).first_or_create do |book|
      book.photo_url = first_book.image_link
      # book.description = first_book.description
      # book.page_count = first_book.page_count
      # book.isbn = first_book.isbn
      # book.created_by = current_user.id
    end
    if @book.save
      create_user_book
      redirect_to book_path(@book)
    else
      render :new
    end
  end
end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def create_user_book
    @user_book = UserBook.new
    @user_book.user = current_user
    @user_book.book = @book
    @user_book.have_read = params[:book][:user_book_attributes]["have_read"]
    @user_book.save
  end

  def book_params
    params.require(:book).permit(:title, :author, user_books_attributes: :have_read )
  end

  def find_book
    @book = Book.find(params[:id])
  end

end
