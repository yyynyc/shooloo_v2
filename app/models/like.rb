class Like < ActiveRecord::Base
  attr_accessible :comment_id, :post_id, :user_id
  belongs_to :post
  belongs_to :comment
  belongs_to :user

  after_create do
    if self.post
      Activity.create!(action: "create", trackable: self, 
        user_id: self.user_id, recipient_id: self.post.user_id)
    elsif self.alarmed_comment
      Activity.create!(action: "create", trackable: self, 
        user_id: self.user_id, recipient_id: self.comment.user_id)
    end    
  end
end
