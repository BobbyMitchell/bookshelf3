class BooksController < ApplicationController

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
   #   book_user = UserBook.create(book: @book, user: current_user, have_or_want: @book.have_read)
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

  def book_params
    params.require(:book).permit(:title, :author)
  end

end
