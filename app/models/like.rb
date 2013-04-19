class Like < ActiveRecord::Base
  attr_accessible :liked_comment_id, :liked_post_id
  belongs_to :liked_post, class_name: "Post"
  belongs_to :liked_comment, class_name: "Comment"
  belongs_to :liker, class_name: "User"

  def post_update_likes
    Post.update_all([
        "likes_count = (select count (*) from likes 
          where liked_post_id=?)", self.liked_post.id],
        ['id=?',self.liked_post.id])
  end

  def comment_update_likes
    Comment.update_all([
        "likes_count = (select count (*) from likes 
          where liked_comment_id=?)", self.liked_comment.id],
        ['id=?',self.liked_comment.id]) 
  end
  
  after_create do 
    if self.liked_post
      post_update_likes
    elsif self.liked_comment
      comment_update_likes
    end     
  end

  after_destroy do 
    if self.liked_post
      post_update_likes
    elsif self.liked_comment
      comment_update_likes
    end  
  end

  after_create do
    if self.liked_post
      Activity.create!(action: "create", trackable: self, 
        user_id: self.liker_id, recipient_id: self.liked_post.user_id)
    elsif self.liked_comment
      Activity.create!(action: "create", trackable: self, 
        user_id: self.liker_id, recipient_id: self.liked_comment.commenter_id)
    end
  end
end