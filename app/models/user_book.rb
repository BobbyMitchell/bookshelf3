class UserBook < ApplicationRecord
  belongs_to :book
  belongs_to :user

  validates :have_read, inclusion: { in: [ true, false ] }

end
