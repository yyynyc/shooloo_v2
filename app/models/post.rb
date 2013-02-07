# == Schema Information
#
# Table name: posts
#
#  id                      :integer          not null, primary key
#  question                :text
#  answer                  :string(255)
#  grade                   :string(255)
#  user_id                 :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  attachment_file_name    :string(255)
#  attachment_content_type :string(255)
#  attachment_file_size    :integer
#  attachment_updated_at   :datetime
#  photo_file_name         :string(255)
#  photo_content_type      :string(255)
#  photo_file_size         :integer
#  photo_updated_at        :datetime

class Post < ActiveRecord::Base
  attr_accessible :answer, :grade, :question, 
    :photo, :photo_remote_url
  attr_reader :photo_remote_url
  belongs_to :user

  has_attached_file :photo, 
    :styles => { 
                :large => "400x400>", 
                :medium => "250x250>",
                :small => "150x150>",
                :thumb => "100x100>" }, 
    url: "/assets/posts/:id/:style/:basename.:extension",
    path: ":rails_root/public/assets/posts/:id/:style/:basename.:extension"

  has_many :ratings, foreign_key: "rated_post_id", dependent: :destroy
  has_many :raters, through: :ratings, source: :rater

  has_many :improvements, through: :ratings
  has_many :operations, through: :ratings
  has_many :flags, through: :ratings

  validates :user_id, presence: true
  validates :question, presence: true
  validates :answer, presence: true, length: {maximum: 100}
  validates :grade, presence: true
  validates_attachment_presence :photo
  validates_attachment_size :photo, :less_than => 5.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png', 'image/pdf']
  default_scope order: 'posts.created_at DESC'

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
    # avatar_file_name == "face.png"
    # avatar_content_type == "image/png"
    @photo_remote_url = url_value
  end
end
