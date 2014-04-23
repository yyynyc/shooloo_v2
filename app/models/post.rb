class Post < ActiveRecord::Base
  require 'obscenity/active_model'
  validates :question, :answer, obscenity: {message: 'contains offensive word'}
  attr_accessible :answer, :grade, :question, :comments_count, :ratings_count, :likes_count,
    :photo, :photo_remote_url, :image_host, :category, :graded, :user_id,
    :level_id, :domain_id, :standard_id, :quality_id, :subject_id, :response_id, 
    :state, :competition
  attr_reader :photo_remote_url
  belongs_to :user
  belongs_to :standard
  belongs_to :domain
  belongs_to :level
  belongs_to :quality
  belongs_to :subject
  belongs_to :response

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
          order: "comments.created_at DESC"
  has_many :commenters, through: :comments, source: :commenter

  has_many :likes, foreign_key: "liked_post_id", dependent: :destroy
  has_many :likers, through: :likes, source: :liker

  has_many :improvements, through: :ratings
  has_many :operations, through: :ratings
  has_many :flags, through: :ratings

  has_many :invites, foreign_key: "invited_post_id", dependent: :destroy
  has_many :inviters, through: :invites
  has_many :invitees, through: :invites

  has_many :lessons, foreign_key: "post_a_id", dependent: :destroy
  has_many :post_bs, through: :lessons
  has_many :reverse_lessons, foreign_key: "post_b_id", class_name: "Lesson", dependent: :destroy
  has_many :post_as, through: :reverse_lessons

  has_many :assignments, foreign_key: "assigned_post_id", dependent: :destroy
  has_many :assigners, through: :assignments, dependent: :destroy

  has_one :grading, foreign_key: "graded_post_id", dependent: :destroy
  has_one :graders, through: :grading, dependent: :destroy
  has_one :mark, through: :grading
  has_one :scorecard
  has_one :color, through: :scorecard

  has_many :keeps, foreign_key: "kept_post_id", dependent: :destroy
  has_many :keepers, through: :keeps

  has_one :correction, foreign_key: "corrected_post_id", dependent: :destroy
  has_many :editor, through: :correction

  state_machine initial: :draft do
    after_transition :on => :submit, :do => [:give_points, :alert_teacher]
    after_transition :on => :publish, :do => [:give_points, :update_stats, :alert_nudger]
    after_transition :on => :verify, :do => [:alert_author, :update_stats, :alert_nudger]

    event :submit do
      transition :draft => :submitted
    end

    event :publish do
      transition :draft => :published      
    end

    event :checkout do
      transition [:submitted, :published] => :under_review
    end

    event :verify do
      transition :under_review => :verified
    end

    state :submitted, :published do
      validates_presence_of :user_id, :subject_id
      validates :answer, presence: true
      validates :question, presence: true, uniqueness: true
      #validates_attachment_presence :photo
      validates_attachment_size :photo, :less_than => 5.megabytes
      validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png', 'image/pdf', 'image/gif', 'image/bmp']
      validate :question_custom
      validate :answer_custom
      validates_presence_of :level_id, :domain_id, :standard_id, :if => :validate_ccss
      
      def question_custom
        if question.downcase.include?(self.user.first_name.downcase) || question.downcase.include?(self.user.last_name.downcase)
          errors.add(:question, "can't contain any part of your real name.")
        end
      end

      def answer_custom
        if answer.downcase.include?(self.user.first_name.downcase) || answer.downcase.include?(self.user.last_name.downcase)
          errors.add(:answer, "can't contain any part of your real name.")
        end
      end

      def validate_ccss
        self.user.role == "teacher" || self.user.admin?
      end
    end
  end

  def give_points 
    Event.create!(benefactor_id: self.user.id, beneficiary_id: 1, 
          event: "new post", value: ShoolooV2::POST_NEW)
  end

  def alert_teacher 
    if !self.response.nil?
      self.response.update_attributes!(completed: true)
      Activity.create!(action: "complete", trackable: self.response, 
        user_id: self.user_id, recipient_id: self.response.assignment.assigner_id)
    end
  end

  def update_stats
    self.likes_count = 0
    self.comments_count = 0
    if self.user.post_count.nil?
      self.user.post_count = 0
    end
    self.user.post_count += 1
    self.user.save(validate: false)
  end

  def alert_nudger 
    self.user.nudgers.uniq.each do |nudger|
      Activity.create!(action: "create", trackable: self, 
        user_id: self.user_id, recipient_id: nudger.id)
    end
  end

  def alert_author 
    Activity.create!(action: "publish", trackable: self, 
      user_id: 1, recipient_id: self.user_id)
  end

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

      self.photo = adapter
      self.image_host = nil
    else
      #require 'pry';binding.pry
      self.photo = URI.parse(url_value)
      # Assuming url_value is http://example.com/photos/face.png
      # photo_file_name == "face.png"
      # photo_content_type == "image/png"
      
      url = URI(url_value)
      self.image_host = url.host    
    end
    @photo_remote_url=url_value
  end

  def rating_by(user)
    user.ratings.find_by_rated_post_id(self.id)
  end

  def has_teacher_comment?
    comments.each do |comment|
      if comment.commenter.role == "teacher"
        return true
      end
    end
    return false
  end

  after_destroy do
    Event.create!(benefactor_id: self.user_id, beneficiary_id: 1, 
        event: "delete post", value: ShoolooV2::POST_DELETE)
    if !self.response.nil?
      self.response.update_attributes!(completed: false)
    end
    Activity.where(trackable_id: self.id, trackable_type: self.class).delete_all
    Lesson.where(post_a_id: self.id).delete_all
    Lesson.where(post_b_id: self.id).delete_all
  end
end
