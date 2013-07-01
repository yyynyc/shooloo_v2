class User < ActiveRecord::Base
  attr_accessible :parent_email, :personal_email, :screen_name, 
    :first_name, :last_name, :grade, :role, :visible, 
    :password, :password_confirmation,
    :avatar, :avatar_remote_url, :privacy, :rules,
    :school_name, :school_url, :social_media_url,
    :referrals_attributes, :authorizations_attributes
  attr_accessor :updating_password
  attr_reader :avatar_remote_url
  has_attached_file :avatar, 
    :styles => {  :small => "60x60#",
                  :thumb => "100x100#" }, 
      default_url: "/attachments/blank.jpg",
      url: "/attachments/users/:id/:style/:basename.:extension",
      path: ":rails_root/public/attachments/users/:id/:style/:basename.:extension"
  
  has_secure_password

  has_many :choices
  has_many :states, dependent: :destroy
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
  has_many :referrers, through: :referrals
  has_many :reverse_referrals, foreign_key: "referrer_id", 
          class_name: "Referral", dependent: :destroy
  has_many :referred_users, through: :reverse_referrals, 
          source: :referred
  accepts_nested_attributes_for :referrals

  has_many :authorizations, foreign_key: "authorized_id", dependent: :destroy
  has_many :authorizers, through: :authorizations
  has_many :reverse_authorizations, foreign_key: "authorizer_id", 
          class_name: "Authorization", dependent: :destroy
  has_many :authorized_users, through: :reverse_authorizations, 
          source: :authorized
  accepts_nested_attributes_for :authorizations

  has_many :invites, foreign_key: "inviter_id", dependent: :destroy
  has_many :invited_posts, through: :invites, source: :invited_post

  has_many :events, foreign_key: "benefactor_id", dependent: :destroy
  has_many :beneficiaries, through: :events
  has_many :reverse_events, foreign_key: "beneficiary_id",
            class_name:  "Event", dependent: :destroy
  has_many :benefators, through: :reverse_events

  has_many :scores, foreign_key: "benefactor_id", dependent: :destroy
  has_many :beneficiaries, through: :scores
  has_many :reverse_scores, foreign_key: "beneficiary_id",
            class_name:  "Score", dependent: :destroy
  has_many :benefators, through: :reverse_scores

  has_many :gifts, foreign_key: "giver_id", dependent: :destroy
  has_many :receivers, through: :gifts
  has_many :reverse_gifts, foreign_key: "receiver_id",
            class_name:  "Gift", dependent: :destroy
  has_many :givers, through: :reverse_gifts

  before_save do
    create_remember_token
  end

  before_update do
    unless self.personal_email.nil?
      self.personal_email.downcase!
    end
    unless self.parent_email.nil?
      self.parent_email.downcase!
    end
    unless self.first_name.nil?
      self.first_name.capitalize!
    end
    unless self.last_name.nil?
      self.last_name.capitalize!
    end
  end

  after_create do 
    Event.create!(benefactor_id: self.id, 
      beneficiary_id: 1, 
      event: "sign up", value: ShoolooV2::SIGN_UP)
  end

  after_update :create_states

  VALID_SCREEN_NAME_REGEX = /^[A-Za-z\d_]+$/
  validates :screen_name, presence: true, format: { with: VALID_SCREEN_NAME_REGEX },
    uniqueness: {case_sensitive: false}, length: { minimum: 6, maximum: 20}
  validates :password, presence: true, length: {minimum: 6}, :if => :should_validate_password?
  validates_confirmation_of :password, :if => :should_validate_password? 
  validates :privacy, presence: true
  validates :rules, presence: true

  validates :first_name, length: {maximum: 25}
  validates :last_name, length: {maximum: 25}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :parent_email, allow_blank: true, format: { with: VALID_EMAIL_REGEX } 
  validates :personal_email, allow_blank: true, format: { with: VALID_EMAIL_REGEX }#,
    #uniqueness: {case_sensitive: false} 
  #validates_presence_of :school_name, :if => :active_student?
  #validates_confirmation_of :email, on: :create
  #validates_attachment_presence :avatar
  #validates_attachment_size :avatar, :less_than => 5.megabytes
  #validates_attachment_content_type :avatar, :content_type => ['image/jpeg', 'image/png', 'image/gif', 'image/bmp']

  def should_validate_password? 
    updating_password || new_record?
  end

  def self.visible
    where(:visible=>true)
  end

  def self.hidden
    where(:visible=>false)
  end

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

  def invite!(post)
    invites.create!(invited_post_id: post.id)
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

  def referred_by?(other_user)
    referrals.find_by_referrer_id(other_user.id)
  end

  def ref_request!(other_user)
    referrals.create!(referrer_id: other_user.id)
  end

  def ref_withdraw!(other_user)
    referrals.find_by_referrer_id(other_user.id).destroy
  end
  
  def create_states
    if self.role == "student" &&
          !self.screen_name.nil? &&
          !self.first_name.nil? &&
          !self.last_name.nil? &&
          !self.role.nil? &&
          !self.grade.nil? &&
          !self.school_name.nil? &&
          !self.parent_email.nil? &&
          self.rules == true &&
          self.privacy == true &&
          State.where(user_id: self.id).blank?   
        State.create!(user_id: self.id, complete: "true")  
    elsif self.role == "teacher" &&
          !self.screen_name.nil? &&
          !self.first_name.nil? &&
          !self.last_name.nil? &&
          !self.role.nil? &&
          !self.school_name.nil? &&
          !self.school_url.nil? &&
          !self.personal_email.nil? &&
          self.rules == true &&
          self.privacy == true &&
          State.where(user_id: self.id).blank?   
        State.create!(user_id: self.id, complete: "true") 
    elsif self.role != "teacher" &&
          self.role != "student" &&
          !self.screen_name.nil? &&
          !self.first_name.nil? &&
          !self.last_name.nil? &&
          !self.role.nil? &&
          !self.social_media_url.nil? &&
          !self.personal_email.nil? &&
          self.rules == true &&
          self.privacy == true &&
          State.where(user_id: self.id).blank?   
        State.create!(user_id: self.id, complete: "true")           
    end
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

  def self.daily_alert
    User.all.each { |u| UserMailer.activity_alert(u).deliver }
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
