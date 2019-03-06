class Book < ApplicationRecord
  has_many :user_books, dependent: :destroy
  accepts_nested_attributes_for :user_books
  has_many :books, through: :user_books
end
