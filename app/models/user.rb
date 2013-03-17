# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  first_name             :string(255)
#  email                  :string(255)
#  email_confirmation     :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  password_digest        :string(255)
#  remember_token         :string(255)
#  admin                  :boolean          default(FALSE)
#  avatar_file_name       :string(255)
#  avatar_content_type    :string(255)
#  avatar_file_size       :integer
#  avatar_updated_at      :datetime
#  screen_name            :string(255)
#  grade                  :string(255)
#  last_name              :string(255)
#  auth_token             :string(255)
#  password_reset_token   :string(255)
#  password_reset_sent_at :datetime
#

class User < ActiveRecord::Base
  attr_accessible :email, :email_confirmation, :screen_name, 
    :first_name, :last_name, :grade, 
    :password, :password_confirmation, :avatar
  has_attached_file :avatar, 
    :styles => {  :small => "60x60#",
                  :thumb => "100x100#" }, 
      url: "/attachments/users/:id/:style/:basename.:extension",
      path: ":rails_root/public/attachments/users/:id/:style/:basename.:extension"
  
  has_secure_password
  has_many :posts, dependent: :destroy, order: "updated_at DESC"
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower

  has_many :ratings, foreign_key: "rater_id", dependent: :destroy, 
          order: "ratings.updated_at DESC"
  has_many :rated_posts, through: :ratings, source: :rated_post,
          order: "ratings.updated_at DESC"
 
  has_many :comments, foreign_key: "commenter_id", dependent: :destroy, 
          order: "comments.created_at DESC"
  has_many :commented_posts, through: :comments, uniq: true, source: :commented_post#, order: 'comments.created_at desc'

  has_many :alarms, foreign_key: "alarmer_id"
  has_many :alarmed_posts, through: :alarms
  has_many :alarmed_comments, through: :alarms
  has_many :activities_as_initiator, class_name: "Activity", as: :initiator
  has_many :activities_as_recipient, class_name: "Activity", as: :recipient
  
  before_save { self.email.downcase! } 
  before_save :create_remember_token
  before_save {self.first_name.capitalize!}
  before_save {self.last_name.capitalize!}
  before_create { generate_token(:auth_token) }

  validates :first_name, presence: true, length: {maximum: 25}
  validates :last_name, presence: true, length: {maximum: 25}
  validates :grade, presence: true
  VALID_SCREEN_NAME_REGEX = /^[A-Za-z\d_]+$/
  validates :screen_name, presence: true, format: { with: VALID_SCREEN_NAME_REGEX },
    uniqueness: {case_sensitive: false}, length: { minimum: 6, maximum: 20}
	
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, 
  	uniqueness: { case_sensitive: false}
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

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save! validate: false
    UserMailer.password_reset(self).deliver
  end


  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

    def generate_token(column)
      begin
        self[column] = SecureRandom.urlsafe_base64
      end while User.exists?(column => self[column])
    end
end
