class User < ActiveRecord::Base
  attr_accessible :email, :email_confirmation, :screen_name, 
    :first_name, :last_name, :grade,  
    :password, :password_confirmation,
    :avatar, :avatar_remote_url, :privacy, :rules,
    :referrals_attributes, :authorizations_attributes
  attr_reader :avatar_remote_url
  has_attached_file :avatar, 
    :styles => {  :small => "60x60#",
                  :thumb => "100x100#" }, 
      url: "/attachments/users/:id/:style/:basename.:extension",
      path: ":rails_root/public/attachments/users/:id/:style/:basename.:extension"
  
  has_secure_password

  has_many :posts, dependent: :destroy, order: "updated_at DESC"
  has_many :activities, dependent: :destroy

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

  has_many :likes, foreign_key: "liker_id", dependent: :destroy
  has_many :liked_posts, through: :likes, source: :liked_post
  has_many :liked_comments, through: :likes, source: :liked_comment

  has_many :nudges, foreign_key: "nudger_id", dependent: :destroy
  has_many :nudged_users, through: :nudges, source: :nudged
  has_many :reverse_nudges, foreign_key: "nudged_id",
                                   class_name:  "Nudge",
                                   dependent:   :destroy
  has_many :nudgers, through: :reverse_nudges, source: :nudger

  has_many :referrals, foreign_key: "referred_id", dependent: :destroy
  has_many :referrers, through: :referrals#, conditions: {approval: "accepted"}
  has_many :reverse_referrals, foreign_key: "referrer_id", 
          class_name: "Referral", dependent: :destroy
  has_many :referred_users, through: :reverse_referrals, 
          source: :referred#, conditions: {approval: "accepted"}
  accepts_nested_attributes_for :referrals

  has_many :authorizations, foreign_key: "authorized_id", dependent: :destroy
  has_many :authorizers, through: :authorizations
  has_many :reverse_authorizations, foreign_key: "authorizer_id", 
          class_name: "Authorization", dependent: :destroy
  has_many :authorized_users, through: :reverse_authorizations, 
          source: :authorized
  accepts_nested_attributes_for :authorizations

  before_save do
    self.email.downcase!
    create_remember_token
    self.first_name.capitalize!
    self.last_name.capitalize!
  end
  
  validates :first_name, presence: true, length: {maximum: 25}
  validates :last_name, presence: true, length: {maximum: 25}
  VALID_SCREEN_NAME_REGEX = /^[A-Za-z\d_]+$/
  validates :screen_name, presence: true, format: { with: VALID_SCREEN_NAME_REGEX },
    uniqueness: {case_sensitive: false}, length: { minimum: 6, maximum: 20}
	
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX } 
  validates_confirmation_of :email, on: :create
  

  validates :password, presence: true, length: {minimum: 6}, on: :create
  validates_confirmation_of :password_confirmation
  validates :privacy, presence: true
  validates :rules, presence: true

  validates_attachment_presence :avatar
  validates_attachment_size :avatar, :less_than => 5.megabytes
  validates_attachment_content_type :avatar, :content_type => ['image/jpeg', 'image/png', 'image/gif', 'image/bmp']

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

  def avatar_remote_url=(url_value) 
    return if url_value.blank?
    self.avatar = URI.parse(url_value)
    @avatar_remote_url = url_value
    url = URI(url_value)   
  end

  def read!(activity)
    Activity.find_by_id(activity.id).update_attributes!(read: true)
  end

  def unread!(activity)
    Activity.find_by_id(activity.id).update_attributes!(read: nil)
  end

  def nudging?(other_user)
    nudges.find_by_nudged_id(other_user.id)
  end

  def nudge!(other_user)
   nudges.create!(nudged_id: other_user.id)
  end

  def disnudge!(other_user)
    nudges.find_by_nudged_id(other_user.id).destroy
  end

  def authorized_by?(other_user)
    authorizations.find_by_authorizer_id(other_user.id)
  end

  def auth_request!(other_user)
    authorizations.create!(authorizer_id: other_user.id)
  end

  def auth_withdraw!(other_user)
    authorizations.find_by_authorizer_id(other_user.id).destroy
  end

  def auth_grant!(other_user)
    reverse_authorizations.find_by_authorized_id(other_user.id).update_attributes!(approval: "accepted")
  end

  def auth_decline!(other_user)
    reverse_authorizations.find_by_authorized_id(other_user.id).update_attributes!(approval: "declined")
  end

  def reputation(age)
    User.cr_joins.cr_for(self.id).cr_sum.first.count.to_i
  end

  def self.cr_from(user_id)
    where('ratings.rater_id= ? or comments.commenter_id=? ', user_id, user_id)
  end

  def cr_age(age)
    where('posts.created_at >= now() - interval ' + quote_value("#{age} second"))
  end

  def self.cr_for(user_id)
    where('users.id=?', user_id)
  end

  def self.cr_joins
    joins(' left join posts on posts.user_id=users.id
      left join comments on comments.commented_post_id=posts.id
      left join ratings on ratings.rated_post_id=posts.id
    ')
  end

  def self.cr_sum
    select('count(distinct ratings.id) + count(distinct comments.id) count')
end

  def self.cr_sum_with_id
    select('count(distinct ratings.id) + count(distinct comments.id) count, users.id')
    end

  def self.cr_order_desc
    order('count(distinct ratings.id) + count(distinct comments.id) desc')
  end

  def self.cr_group_user
    group('users.id')
  end

  def self.cr_count
    first.count.to_i
    end

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
