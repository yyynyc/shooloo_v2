# == Schema Information
#
# Table name: users
#
#  id                  :integer          not null, primary key
#  first_name          :string(255)
#  email               :string(255)
#  email_confirmation  :string(255)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  password_digest     :string(255)
#  remember_token      :string(255)
#  admin               :boolean          default(FALSE)
#  avatar_file_name    :string(255)
#  avatar_content_type :string(255)
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#  screen_name         :string(255)
#  grade               :string(255)
#  last_name           :string(255)
#

class User < ActiveRecord::Base
  attr_accessible :email, :email_confirmation, :screen_name, 
    :first_name, :last_name, :grade, 
    :password, :password_confirmation, :avatar
  has_attached_file :avatar, 
    :styles => { 
                  :large => "600x600>", 
                  :medium => "250x250>",
                  :small => "60x60#",
                  :thumb => "100x100#" }, 
      url: "/assets/posts/:id/:style/:basename.:extension",
      path: ":rails_root/public/assets/posts/:id/:style/:basename.:extension"
  
  has_secure_password
  has_many :posts, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower

  has_many :ratings, foreign_key: "rater_id", dependent: :destroy
  has_many :rated_posts, through: :ratings, source: :rated_post
  
  before_save { self.email.downcase! } 
  before_save :create_remember_token


  validates :first_name, presence: true, length: {maximum: 25}
  validates :last_name, presence: true, length: {maximum: 25}
  validates :grade, presence: true
  VALID_SCREEN_NAME_REGEX = /^[A-Za-z\d_]+$/
  validates :screen_name, presence: true, format: { with: VALID_SCREEN_NAME_REGEX },
    uniqueness: {case_sensitive: false}, length: { minimum: 6, maximum: 20}
	
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, 
  	uniqueness: { case_sensitive: false}
  validates :email_confirmation, presence: true
  validates_confirmation_of :email
  

  validates :password, presence: true, length: {minimum: 6}
  validates :password_confirmation, presence: true

  validates_attachment_presence :avatar
  validates_attachment_size :avatar, :less_than => 5.megabytes
  validates_attachment_content_type :avatar, :content_type => ['image/jpeg', 'image/png']

  def feed
    Post.from_users_followed_by(self)
  end

  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

end
