class Relationship < ApplicationRecord
  # follower_idとかfollowed_idとか言ってるけど中身はuserのことだよって意味
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
end
