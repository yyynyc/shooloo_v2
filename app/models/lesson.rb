class Lesson < ActiveRecord::Base
  attr_accessible :description, :domain_id, :level_id, :practice_id, 
  	:post_a_id, :post_b_id, :standard_id, :user_id, :file

  	belongs_to :post_a, class_name: "Post"
    belongs_to :post_b, class_name: "Post"
    belongs_to :user
  	belongs_to :level
  	belongs_to :domain
  	belongs_to :standard
    belongs_to :hstandard
    belongs_to :practice

    has_many :likes, foreign_key: "liked_lesson_id", dependent: :destroy
    has_many :likers, through: :likes

    has_many :comments, foreign_key: "commented_lesson_id", dependent: :destroy, 
          order: "comments.created_at DESC"
    has_many :commenters, through: :comments

  	has_attached_file :file,   
    url: "/attachments/lessons/:id/:basename.:extension",
    path: ":rails_root/public/attachments/lessons/:id/:basename.:extension"

    before_post_process :image?
    def image?
    	!(file_content_type =~ /^image.*/).nil?
    end

    validates_presence_of :description, :domain_id, :level_id, :standard_id, :practice_id
    validates :post_a_id, numericality: true, allow_blank: true 
    validates :post_b_id, numericality: true, allow_blank: true
end
