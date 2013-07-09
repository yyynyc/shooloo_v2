class Post < ActiveRecord::Base
  attr_accessible :answer, :grade, :question, 
    :photo, :photo_remote_url, :image_host, :category
  attr_reader :photo_remote_url
  belongs_to :user
  belongs_to :standard
  belongs_to :domain
  belongs_to :grade

  has_attached_file :photo, 
    :styles => { 
                :large => "400x400>", 
                :medium => "250x250>",
                :small => "150x150>",
                :thumb => "100x100>" }, 
    default_url: "/attachments/Shooloo_logo_small.png",            
    url: "/attachments/posts/:id/:style/:basename.:extension",
    path: ":rails_root/public/attachments/posts/:id/:style/:basename.:extension"

  has_many :alarms, foreign_key: "alarmed_post_id", dependent: :destroy

  has_many :ratings, foreign_key: "rated_post_id", dependent: :destroy, 
          order: "ratings.updated_at DESC"
  has_many :raters, through: :ratings, source: :rater

  has_many :comments, foreign_key: "commented_post_id", dependent: :destroy, 
          order: "comments.updated_at DESC"
  has_many :commenters, through: :comments, source: :commenter

  has_many :likes, foreign_key: "liked_post_id", dependent: :destroy
  has_many :likers, through: :likes, source: :liker

  has_many :improvements, through: :ratings
  has_many :operations, through: :ratings
  has_many :flags, through: :ratings

  has_many :invites, foreign_key: "invited_post_id", dependent: :destroy
  has_many :inviters, through: :invites
  has_many :invitees, through: :invites
  
  validates_presence_of :user_id, :question, :grade, :category
  validates :answer, presence: true, length: {maximum: 100}
  #validates_attachment_presence :photo
  #validates_attachment_size :photo, :less_than => 5.megabytes
  #validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png', 'image/pdf', 'image/gif', 'image/bmp']

  def after_initialize
    @visible = true if @visible.nil?
  end

  def self.visible
    where(:visible=>true)
  end

  def self.hidden
    where(:visible=>false)
  end

  def self.with_comments
    where('exists (select 1 from comments where comments.commented_post_id=post.id)')
  end

  # Returns posts from the users being followed by the given user.
  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", 
          user_id: user.id)
  end

  def photo_remote_url=(url_value) 
    return if url_value.blank?
    self.photo = URI.parse(url_value)
    # Assuming url_value is http://example.com/photos/face.png
    # photo_file_name == "face.png"
    # photo_content_type == "image/png"
    @photo_remote_url = url_value
    url = URI(url_value)
    self.image_host = url.host    
  end

  def rating_by(user)
    user.ratings.find_by_rated_post_id(self.id)
  end

  after_create do
    Event.create!(benefactor_id: self.user_id, beneficiary_id: 1, 
        event: "new post", value: ShoolooV2::POST_NEW)
    self.user.nudgers.uniq.each do |nudger|
      Activity.create!(action: "create", trackable: self, 
        user_id: self.user_id, recipient_id: nudger.id)
    end
  end

  after_destroy do
    Event.create!(benefactor_id: self.user_id, beneficiary_id: 1, 
        event: "delete post", value: ShoolooV2::POST_DELETE)
  end

  after_update do
    self.commenters.uniq.each do |commenter|
      Activity.create!(action: "update", trackable: self, 
        user_id: self.user_id, recipient_id: commenter.id)
    end

    self.raters.uniq.each do |rater|
      Activity.create!(action: "update", trackable: self, 
        user_id: self.user_id, recipient_id: rater.id)
    end
  end
end
