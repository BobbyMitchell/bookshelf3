require 'rails_helper'

RSpec.describe BooksController, type: :controller do

  describe "#create" do
    it "creates a book" do
      expect { post :create, params: {book: {title: "Book", author: "Me"}}}.to change(Book, :count).by(1)
    end
  end
end
