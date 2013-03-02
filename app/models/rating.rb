# == Schema Information
#
# Table name: ratings
#
#  id                 :integer          not null, primary key
#  rater_id           :integer
#  rated_post_id      :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  answer_correctness :integer
#  steps              :integer
#  grade_suitability  :integer
#  overall_rating     :boolean
#

class Rating < ActiveRecord::Base
  attr_accessible :rated_post_id, :answer_correctness, :steps, :grade_suitability, 
				  :operation_ids, :improvement_ids, :flag_ids, :overall_rating 

  belongs_to :rated_post, class_name: "Post"
  belongs_to :rater, class_name: "User"

  has_many :operations, order: "position"
  accepts_nested_attributes_for :operations
  has_many :improvements, order: "position"
  accepts_nested_attributes_for :improvements
  has_many :flags, order: "position"
  accepts_nested_attributes_for :flags 

  validates :rated_post_id, presence: true
  validates :rater_id, presence: true
  validates :answer_correctness, presence: true
  validates :steps, presence: true
  validates :grade_suitability, presence: true
  validates_inclusion_of :overall_rating, in: [true, false]
  validates_associated :operations
  validates_presence_of :operations

  default_scope order: 'ratings.updated_at DESC'

end
