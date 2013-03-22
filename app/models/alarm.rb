class Alarm < ActiveRecord::Base
  attr_accessible :alarmed_comment_id, :alarmed_post_id
  belongs_to :alarmed_post, class_name: "Post"
  belongs_to :alarmed_comment, class_name: "Comment"
  belongs_to :alarmer, class_name: "User"

  after_save do 
  	if self.alarmed_post
    	#Post.update_all(["visible=?", false], ['id=?',self.alarmed_post.id])
      self.alarmed_post.update_attribute(:visible, false)
    elsif self.alarmed_comment
    	#Comment.update_all(['visible=?', false],['id=?',self.alarmed_comment.id])
      self.alarmed_comment.update_attribute(:visible, false)
    end
  end

  after_destroy do 
    if self.alarmed_post
      Post.update_all(["visible=?", true], ['id=?',self.alarmed_post.id])
    elsif self.alarmed_comment
      Comment.update_all(['visible=?', true],['id=?',self.alarmed_comment.id])
    end
  end
end
