class User < ActiveRecord::Base

  attr_accessible :parent_email, :personal_email, :screen_name, :full_name_us, :full_name_uk, 
    :first_name, :last_name, :grade, :role, :visible, :birth_date,
    :password, :password_confirmation,
    :avatar, :avatar_remote_url, :privacy, :rules,
    :school_name, :school_url, :social_media_url,
    :referrals_attributes, :authorizations_attributes, 
    :post_count, :rating_count, :comment_count, :follower_count, :following_count,
    :gift_received_count, :gift_sent_count, :pubcred, :correction_count,
    :address_city, :address_state
  attr_accessor :updating_password, :create_student, :self_signup, :validate_student, :validate_teacher, :validate_other
  attr_reader :avatar_remote_url
  has_attached_file :avatar, 
    :styles => {  :small => "60x60#",
                  :thumb => "100x100#" }, 
      default_url: "/attachments/blank.jpg",
      url: "/attachments/users/:id/:style/:basename.:extension",
      path: ":rails_root/public/attachments/users/:id/:style/:basename.:extension"

  has_secure_password

  has_many :choices
  has_many :gradings, foreign_key: "grader_id", dependent: :destroy
  has_many :reverse_gradings, foreign_key: "gradee_id", class_name: "Grading", dependent: :destroy
  has_one :nature, dependent: :destroy
  has_many :lessons, dependent: :destroy
  has_many :posts, dependent: :destroy, order: "created_at DESC"
  has_many :activities, dependent: :destroy
  has_many :homeworks, dependent: :destroy

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
  has_many :commented_posts, through: :comments, uniq: true, source: :commented_post

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
  has_many :benefactors, through: :reverse_scores

  has_many :gifts, foreign_key: "giver_id", dependent: :destroy
  has_many :receivers, through: :gifts
  has_many :reverse_gifts, foreign_key: "receiver_id",
            class_name:  "Gift", dependent: :destroy
  has_many :givers, through: :reverse_gifts

  has_many :assignments, foreign_key: "assigner_id", dependent: :destroy
  has_many :assigned_posts, through: :assignments
  has_many :responses, through: :assignments, foreign_key: "assigner_id"
  has_many :reverse_responses, foreign_key: "assignee_id", dependent: :destroy, class_name:"Response"
  has_many :assigners, through: :reverse_responses

  has_many :reminders, foreign_key: "teacher_id", dependent: :destroy
  has_many :remindees, through: :reminders
  has_many :reminded_responses, through: :reminders
  has_many :reverse_reminders, foreign_key: "remindee_id", dependent: :destroy, class_name: "Reminder"
  has_many :teachers, through: :reverse_reminders
  has_many :reverse_reminded_responses, through: :reverse_reminders

  has_many :keeps, foreign_key: "keeper_id", dependent: :destroy
  has_many :kept_posts, through: :keeps

  has_one :introduction, foreign_key: "introducee_id", dependent: :destroy
  has_one :introducer, through: :introduction
  has_many :reverse_introductions, foreign_key: "introducer_id", 
          class_name: "Introduction", dependent: :destroy
  has_many :introducees, through: :reverse_introductions

  has_many :checks, foreign_key: "checker_id", dependent: :destroy
  has_many :checked_posts, through: :checks

  has_one :point
  has_one :student_contest
  has_many :invitemails

  has_many :corrections, foreign_key: "editor_id"
  has_many :corrected_posts, through: :corrections

  before_save do
    create_remember_token
  end

  after_create do 
    Event.create!(benefactor_id: self.id, beneficiary_id: 1, 
      event: "sign up", value: ShoolooV2::SIGN_UP)
    Activity.create!(action: "create", trackable: self, 
        user_id: self.id, recipient_id: 2)
    unless self.personal_email.blank?
      UserMailer.sign_up_confirm(self).deliver
    end
    Point.create!(user_id: self.id)
    if self.role != "student"
      StudentContest.create!(user_id: self.id)
    else
      self.pubcred = ShoolooV2::PUBLICATION_CREDIT
      self.save(validate: false)
    end
  end

  before_save do
    unless self.role.nil?
      self.role.downcase!
    end
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

  after_destroy do 
    Activity.where(recipient_id: self.id).delete_all
    Score.where(benefactor_id: self.id).delete_all
    Score.where(beneficiary_id: self.id).delete_all
    Event.where(benefactor_id: self.id).delete_all
    Event.where(beneficiary_id: self.id).delete_all
    Homework.where(user_id: self.id).delete_all
    Reminder.where(remindee_id: self.id).delete_all
    Reminder.where(teacher_id: self.id).delete_all
  end

  VALID_SCREEN_NAME_REGEX = /^[A-Za-z\d_]+$/
  validates :screen_name, presence: true, format: { with: VALID_SCREEN_NAME_REGEX, message: "can't contain any space or punctuation" },
    uniqueness: {case_sensitive: false}, length: { minimum: 6, maximum: 20}
  validates :password, presence: true, length: {minimum: 6}, :if => :should_validate_password?
  validates_confirmation_of :password, :if => :should_validate_password? 
  validates :privacy, presence: true
  validates :rules, presence: true
  validates :role, presence: true
  validates :first_name, length: {maximum: 25}, presence: true, on: :create
  validates :last_name, length: {maximum: 25}, presence: true, on: :create 
  validates :personal_email, presence: true, uniqueness: {case_sensitive: false}, on: :create,
    :if => :should_validate_email?
  validates :birth_date, presence: true, on: :create, :if => :should_validate_birthday?
  validates :grade, presence: true, on: :create, :if => :should_validate_birthday?
  validate :screen_name_custom
  validate :under_age, on: :create
  

  def screen_name_custom
    if !first_name.nil? && !last_name.nil?
      if screen_name.downcase.include?(first_name.downcase) || screen_name.downcase.include?(last_name.downcase)
        errors.add(:screen_name, "can't contain any part of your real name.")
      end
    end
  end

  def under_age
    if role=="student" && !birth_date.nil? && (birth_date > (Date.today - 13.years))
      errors.add(:base, "Sorry, but you are under age. You must get your teacher or parent to create an account for you.")
    end
  end

  #validates :school_url, presence: true, url: true, :if => :verify_teacher
  #validates_presence_of :school_name, :if => :active_student?
  #validates_confirmation_of :email, on: :create
  #validates_attachment_presence :avatar
  #validates_attachment_size :avatar, :less_than => 5.megabytes
  #validates_attachment_content_type :avatar, :content_type => ['image/jpeg', 'image/png', 'image/gif', 'image/bmp']

  state_machine initial: :incomplete do
    after_transition :on => :finish, :do => [:give_points, :alert_parent] 
    after_transition :on => :admin_edit, :do => [:grant_authorization] 

    event :finish do
      transition :incomplete => :complete
    end

    event :admin_edit do
      transition [:incomplete, :complete] => :admin_editted
    end

    state :complete, :admin_editted do
      VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
      validates :parent_email, format: { with: VALID_EMAIL_REGEX }, presence: true, 
        :if => :student?, :unless => :should_validate_password? 
      validates :grade, presence: true, numericality: true, allow_blank: true, 
        :if => :student?, :unless => :should_validate_password? 
      validates :school_name, presence: true, length: {maximum: 100}, 
        :if => :validate_school
      validates :personal_email, format: { with: VALID_EMAIL_REGEX }, 
        uniqueness: {case_sensitive: false}, presence: true, 
        :unless => :student?
      validates :personal_email, format: { with: VALID_EMAIL_REGEX }, 
        allow_blank: true, :if => :student?
      #validates :social_media_url, presence: true, :if => :other?
      validates :address_city, presence: true, on: :update, 
        :unless => :should_validate_password?
      validates :address_state, presence: true, on: :update, 
        :unless => :should_validate_password?
      validates :school_url, presence: true, :if => :teacher?, 
        :unless => :should_validate_password?
      validates :first_name, length: {maximum: 25}, presence: true
      validates :last_name, length: {maximum: 25}, presence: true      

      def validate_school
        if self.role.in?(["student", "teacher"])
          return true
        end
      end

      def student?
        if self.role == "student"
          return true
        else
          return false
        end
      end

      def teacher?
        if self.role == "teacher"
          return true
        else
          return false
        end
      end

      def other?
        if self.role != "student" && self.role != "teacher"
          return true
        else
          return false
        end
      end
    end
  end

  def grant_authorization
    Authorization.create!(authorized_id: self.id, authorizer_id: 1, approval: "accepted")
    UserMailer.admin_edit(self).deliver
  end

  def give_points
    Event.create!(benefactor_id: self.id, beneficiary_id: 1, 
      event: "complete user profile", value: ShoolooV2::PROFILE_COMPLETE)
  end

  def alert_parent
    if self.role == "student" && !self.parent_email.blank?
      UserMailer.parental_consent(self).deliver
    end
  end

  def past_homeworks
    assignments.where("end_date<?", Time.now).last(4)
  end

  def no_post_students
    authorized_users.order('grade ASC, last_name ASC').keep_if{|s| s.posts.where(state: 
      ["submitted", "published", "old", "revised"]).blank?}
  end

  def ungraded_students
    authorized_users.order('grade ASC, last_name ASC').keep_if{|s| s.posts.where(state: 
      ["submitted", "published", "old", "revised"]).any? && s.posts.where(graded: true).blank?
      }
  end

  def below_grade_students
    authorized_users.order('grade ASC, last_name ASC').keep_if{|s| s.posts.where(state: 
      ["verified", "published", "old", "revised"]).any? && !s.grade.nil? && s.posts.where(state: 
      ["verified", "published", "old", "revised"]).map(&:level).uniq.sort.last.number<s.grade}
  end

  def no_login_students
    authorized_users.order('grade ASC, last_name ASC').keep_if{|s| s.homework_last_week.nil? && s.homework_prior_week.nil? && 
      s.homework_current_week.nil?}
  end

  def full_name_us
    "#{first_name} #{last_name}"
  end

  def full_name_uk
    "#{last_name}, #{first_name}"
  end

  def should_validate_password? 
    updating_password || new_record?
  end

  def should_validate_birthday? 
    create_student
  end

  def should_validate_email? 
    self_signup
  end

  def self.visible
    where(:visible=>true)
  end

  def self.hidden
    where(:visible=>false)
  end

  def feed
    Post.where(state:["published", "verified", "old", "revised"], toreview: ["false", nil]).from_users_followed_by(self)
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
    if url_value.start_with?('data:')
      adapter = Paperclip.io_adapters.for(url_value)
      if url_value =~ /\Adata:([;]+);/
        content_type = $1
        mime_type = MIME::Types[content_type].first
        if mime_type
          extension = mime_type.extensions.first
          adapter.original_filename = "base64.#{extension}"
        end
      end

      self.avatar = adapter
    else
      #require 'pry';binding.pry
      self.avatar = URI.parse(url_value)
      # Assuming url_value is http://example.com/photos/face.png
      # photo_file_name == "face.png"
      # photo_content_type == "image/png"
      
      url = URI(url_value)   
    end
    @avatar_remote_url=url_value
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

  def auth_delete!(other_user)
    authorizations.find_by_authorized_id(other_user.id).destroy
  end

  def auth_grant!(other_user)
    reverse_authorizations.find_by_authorized_id(other_user.id).update_attributes!(approval: "accepted")
  end

  def auth_decline!(other_user)
    reverse_authorizations.find_by_authorized_id(other_user.id).update_attributes!(approval: "declined")
  end

  def reset_password!(other_user)
    u=User.find_by_id(other_user.id)
    u.updating_password=true
    u.update_attributes!(password: "shooloo", password_confirmation: "shooloo")
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
    User.all.each do |u| 
      unless u.personal_email.blank?
        UserMailer.activity_alert(u).deliver 
      end
    end
  end

  def homework_current_week
    homeworks.find_by_week_and_year(Time.now.strftime('%W'), Time.now.strftime('%Y'))
  end

  def homework_last_week
    homeworks.find_by_week_and_year(Time.now.strftime('%W').to_i - 1, Time.now.strftime('%Y'))
  end

  def homework_prior_week
    homeworks.find_by_week_and_year(Time.now.strftime('%W').to_i - 2, Time.now.strftime('%Y'))
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |user|
        csv << user.attributes.values_at(*column_names)
      end
    end
  end

private

  def create_remember_token
    if self.remember_token.blank?
      self.remember_token = SecureRandom.urlsafe_base64
    end
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end  
end
