class UserBooksController < ApplicationController

  def new

  end

  def create
    @book = Book.find(params[:book_id])
    destroy_previous_user_book
    @user_book = UserBook.new
    @user_book.have_read = params[:user_book]["have_read"]
    @user_book.book_id = @book.id
    @user_book.user = current_user
    @user_book.save
    redirect_to book_path(@book)
  end

  private

  def user_book_params
    params.require(:user_book).permit(:id, :book_id, :have_read, :rating, :user_id)
  end

  def destroy_previous_user_book
    if current_user.books.include? @book
      UserBook.where(user: current_user, book: @book).destroy_all
    end
  end
end
