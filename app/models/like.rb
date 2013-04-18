class Like < ActiveRecord::Base
  attr_accessible :liked_comment_id, :liked_post_id
  belongs_to :liked_post, class_name: "Post"
  belongs_to :liked_comment, class_name: "Comment"
  belongs_to :liker, class_name: "User"
end