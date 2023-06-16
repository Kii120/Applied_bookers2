class Favorite < ApplicationRecord
  
  belongs_to :user
  belongs_to :book
  
  validates :user_id, uniqueness: { scope: :book_id} 
  #1つの投稿に対してしかいいねできない
  
end
