# == Schema Information
#
# Table name: comments
#
#  id                 :integer          not null, primary key
#  comment            :text
#  photo_file_name    :string(255)
#  photo_content_type :string(255)
#  photo_file_size    :integer
#  photo_updated_at   :datetime
#  commenter_id       :integer
#  commented_post_id  :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Comment < ActiveRecord::Base
  attr_accessible :content, :photo
  belongs_to :commented_post, class_name: "Post"
  belongs_to :commenter, class_name: "User"
  has_many :alarms, foreign_key: "alarmed_comment_id", dependent: :destroy

  has_attached_file :photo, 
    :styles => {:medium => "250x250>"},                
    url: "/attachments/comments/:id/:style/:basename.:extension",
    path: ":rails_root/public/attachments/comments/:id/:style/:basename.:extension"

  validates :commented_post_id, presence: true
  validates :commenter_id, presence: true
  validates :content, presence: true

  default_scope order: 'comments.created_at DESC'

  after_save do 
    Post.update_all([
      "comments_count = (select count (*) from comments 
        where commented_post_id=?)", self.commented_post.id],
     	['id=?',self.commented_post.id])
  end
end
