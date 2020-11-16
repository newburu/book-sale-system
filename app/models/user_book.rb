class UserBook < ApplicationRecord
  belongs_to :user
  belongs_to :book, foreign_key: :isbn, primary_key: :isbn
end
