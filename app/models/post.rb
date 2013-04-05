# == Schema Information
#
# Table name: posts
#
#  id                             :integer          not null, primary key
#  question                       :text
#  answer                         :string(255)
#  grade                          :string(255)
#  user_id                        :integer
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#  attachment_file_name           :string(255)
#  attachment_content_type        :string(255)
#  attachment_file_size           :integer
#  attachment_updated_at          :datetime
#  photo_file_name                :string(255)
#  photo_content_type             :string(255)
#  photo_file_size                :integer
#  photo_updated_at               :datetime
#  category                       :string(255)
#  image_host                     :string(255)
#  answer_correctness_1_count     :integer
#  answer_correctness_2_count     :integer
#  answer_correctness_3_count     :integer
#  answer_correctness_4_count     :integer
#  operation_whole_count          :integer
#  visible                        :boolean
#  ratings_count                  :integer
#  overall_true_count             :integer
#  overall_false_count            :integer
#  grade_below_count              :integer
#  grade_right_count              :integer
#  grade_above_count              :integer
#  steps_1_count                  :integer
#  steps_2_count                  :integer
#  steps_3_count                  :integer
#  steps_4_count                  :integer
#  steps_5_count                  :integer
#  steps_6_count                  :integer
#  operation_decimal_count        :integer
#  operation_fraction_count       :integer
#  operation_percentage_count     :integer
#  operation_negative_count       :integer
#  operation_addition_count       :integer
#  operation_substraction_count   :integer
#  operation_multiplication_count :integer
#  operation_division_count       :integer
#  vocabulary_count               :integer
#  grammar_count                  :integer
#  structure_count                :integer
#  clarity_count                  :integer
#  originality_count              :integer
#  plagerism_count                :integer
#  content_count                  :integer
#  image_count                    :integer
#

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
#  category                :string(255)
#

class Post < ActiveRecord::Base
  attr_accessible :answer, :grade, :question, 
    :photo, :photo_remote_url, :image_host, :category
  attr_reader :photo_remote_url
  belongs_to :user

  has_attached_file :photo, 
    :styles => { 
                :large => "400x400>", 
                :medium => "250x250>",
                :small => "150x150>",
                :thumb => "100x100>" }, 
    url: "/attachments/posts/:id/:style/:basename.:extension",
    path: ":rails_root/public/attachments/posts/:id/:style/:basename.:extension"

  has_many :ratings, foreign_key: "rated_post_id", dependent: :destroy, 
          order: "ratings.updated_at DESC"
  has_many :raters, through: :ratings, source: :rater

  has_many :comments, foreign_key: "commented_post_id", dependent: :destroy, 
          order: "comments.updated_at DESC"
  has_many :commenters, through: :comments, source: :commenter

  has_many :improvements, through: :ratings
  has_many :operations, through: :ratings
  has_many :flags, through: :ratings
  
  validates :user_id, presence: true
  validates :question, presence: true
  validates :answer, presence: true, length: {maximum: 100}
  validates :grade, presence: true
  validates :category, presence: true
  validates_attachment_presence :photo
  validates_attachment_size :photo, :less_than => 5.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png', 'image/pdf', 'image/gif', 'image/bmp']

  #default_scope order: 'posts.updated_at DESC'

  has_many :alarms, foreign_key: "alarmed_post_id", dependent: :destroy
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
end
