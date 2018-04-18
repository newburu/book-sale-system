class UserWriter < ApplicationRecord
  belongs_to :user
  belongs_to :writer
end
