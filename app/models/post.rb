class Post < ApplicationRecord
  validates :title , presence:true, length: {in: 5..50}
  validates :body, presence:true, length: {in: 10..300}
  belongs_to :user
  has_many :comments
end
