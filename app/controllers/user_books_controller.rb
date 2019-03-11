class UserBooksController < ApplicationController

  def new

  end

  def create
    raise
    @book = Book.find(params[:book_id])
    @user_book = UserBook.new(user_book_params)
    @user_book.book_id = @book.id
    @user_book.user = current_user
    @user_book.save
    redirect_to book_path(@book)
  end


  private

  def user_book_params
    params.require(:user_book).permit(:book_id, :have_or_want, :rating, :user_id, :_destroy)
  end
end
