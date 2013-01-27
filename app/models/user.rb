# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  email              :string(255)
#  email_confirmation :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  password_digest    :string(255)
#  remember_token     :string(255)
#  admin              :boolean          default(FALSE)
#

class User < ActiveRecord::Base
  attr_accessible :email, :email_confirmation, :name, 
    :password, :password_confirmation, :avatar
  has_attached_file :avatar, 
    :styles => { 
                  :large => "600x600>", 
                  :medium => "250x250>",
                  :small => "150x150>",
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
  
  before_save { self.email.downcase! } 
  before_save :create_remember_token


  validates :name, presence: true, length: {maximum: 50}
	
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, 
  	uniqueness: { case_sensitive: false}
  validates :email_confirmation, presence: true, format: { with: VALID_EMAIL_REGEX}
  

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
