class Comment < ApplicationRecord
  validates :body, presence:true, length: {in: 10..100}
  
  belongs_to :user
  belongs_to :post
end
