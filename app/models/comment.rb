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

  has_attached_file :photo, 
    :styles => {:large => "800x800>",
                :small => "60x60>"},                
    url: "/attachments/comments/:id/:style/:basename.:extension",
    path: ":rails_root/public/attachments/comments/:id/:style/:basename.:extension"

  validates :commented_post_id, presence: true
  validates :commenter_id, presence: true
  validates :content, presence: true

  has_many :alarms, foreign_key: "alarmed_comment_id", dependent: :destroy


  def after_initialize
    @visible = true if @visible.nil?
  end

  def self.visible
    where(:visible=>true)
  end

  def self.hidden
    where(:visible=>false)
  end

  #default_scope order: 'comments.created_at DESC'

  after_save do 
    Post.update_all([
      "comments_count = (select count (*) from comments 
        where commented_post_id=?)", self.commented_post.id],
     	['id=?',self.commented_post.id])
  end

  after_destroy do 
    Post.update_all([
      "comments_count = (select count (*) from comments 
        where commented_post_id=?)", self.commented_post.id],
      ['id=?',self.commented_post.id])
  end

  after_create do
    Activity.create!(action: "create", trackable: self, 
      user_id: self.commenter_id, recipient_id: self.commented_post.user_id)

    self.commented_post.commenters.uniq.each do |c|
      Activity.create!(action: "create", trackable: self, 
        user_id: self.commenter_id, recipient_id: c.id)
    end
  end
end
