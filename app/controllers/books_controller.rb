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
      create_user_book
      redirect_to books_path
    else
      render :new
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
