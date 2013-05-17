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
  attr_accessible :answer_correctness, :steps, :grade_suitability, 
				  :operation_ids, :improvement_ids, :flag_ids, :overall_rating 

  belongs_to :rated_post, class_name: "Post"
  belongs_to :rater, class_name: "User"

  has_many :operations, order: "position"
  accepts_nested_attributes_for :operations
  has_many :improvements, order: "position"
  accepts_nested_attributes_for :improvements
  has_many :flags, order: "position"
  accepts_nested_attributes_for :flags 

  validates_presence_of :rated_post_id, :rater_id, :answer_correctness, 
    :steps, :grade_suitability, :operations
  validates_inclusion_of :overall_rating, in: [true, false]
  validates_associated :operations

  default_scope order: 'ratings.updated_at DESC'

  after_create do
    Activity.create!(action: "create", trackable: self, 
      user_id: self.rater_id, recipient_id: self.rated_post.user_id)

    if self.rated_post.raters.count > 1
      self.rated_post.raters.uniq.each do |r|
        Activity.create!(action: "create", trackable: self, 
          user_id: self.rater_id, recipient_id: r.id)
      end
    end
  end
  
  after_save :update_rating_counts
  after_destroy :update_rating_counts

  def update_rating_counts
    Post.update_all([
      "ratings_count = (select count (*) from ratings 
        where rated_post_id=?),
      overall_true_count = (select count (*) from ratings 
        where rated_post_id=? and overall_rating='true'),
      overall_false_count = (select count (*) from ratings 
        where rated_post_id=? and overall_rating='false'),
      grade_below_count = (select count (*) from ratings 
        where rated_post_id=? and grade_suitability=1),
      grade_right_count = (select count (*) from ratings 
        where rated_post_id=? and grade_suitability=2),
      grade_above_count = (select count (*) from ratings 
        where rated_post_id=? and grade_suitability=3),
      answer_correctness_1_count = (select count (*) from ratings 
        where rated_post_id=? and answer_correctness=1),
      answer_correctness_2_count = (select count (*) from ratings 
        where rated_post_id=? and answer_correctness=2),
      answer_correctness_3_count = (select count (*) from ratings 
        where rated_post_id=? and answer_correctness=3),
      answer_correctness_4_count = (select count (*) from ratings 
        where rated_post_id=? and answer_correctness=4),
      steps_1_count = (select count (*) from ratings 
        where rated_post_id=? and steps=1),
      steps_2_count = (select count (*) from ratings 
        where rated_post_id=? and steps=2),
      steps_3_count = (select count (*) from ratings 
        where rated_post_id=? and steps=3),
      steps_4_count = (select count (*) from ratings 
        where rated_post_id=? and steps=4),
      steps_5_count = (select count (*) from ratings 
        where rated_post_id=? and steps=5),
      steps_6_count = (select count (*) from ratings 
        where rated_post_id=? and steps=6),
      operation_whole_count = (select count (*) from operations, ratings 
        where rated_post_id=? and name='whole number'
        and ratings.id=operations.rating_id),
      operation_decimal_count = (select count (*) from operations, ratings 
        where rated_post_id=? and name='decimal point'
        and ratings.id=operations.rating_id),
      operation_fraction_count = (select count (*) from operations, ratings 
        where rated_post_id=? and name='fraction'
        and ratings.id=operations.rating_id),
      operation_percentage_count = (select count (*) from operations, ratings 
        where rated_post_id=? and name='percentage'
        and ratings.id=operations.rating_id),
      operation_negative_count = (select count (*) from operations, ratings 
        where rated_post_id=? and name='negative number'
        and ratings.id=operations.rating_id),
      operation_addition_count = (select count (*) from operations, ratings 
        where rated_post_id=? and name='addition'
        and ratings.id=operations.rating_id),
      operation_substraction_count = (select count (*) from operations, ratings 
        where rated_post_id=? and name='substraction'
        and ratings.id=operations.rating_id),
      operation_multiplication_count = (select count (*) from operations, ratings 
        where rated_post_id=? and name='multiplication'
        and ratings.id=operations.rating_id),
      operation_division_count = (select count (*) from operations, ratings 
        where rated_post_id=? and name='division'
        and ratings.id=operations.rating_id),
      vocabulary_count = (select count (*) from improvements, ratings 
        where rated_post_id=? and name='vocabulary'
        and ratings.id=improvements.rating_id),
      grammar_count = (select count (*) from improvements, ratings 
        where rated_post_id=? and name='grammar'
        and ratings.id=improvements.rating_id),
      structure_count = (select count (*) from improvements, ratings 
        where rated_post_id=? and name='structure'
        and ratings.id=improvements.rating_id),
      clarity_count = (select count (*) from improvements, ratings 
        where rated_post_id=? and name='concept clarity'
        and ratings.id=improvements.rating_id),
      originality_count = (select count (*) from improvements, ratings 
        where rated_post_id=? and name='originality'
        and ratings.id=improvements.rating_id),
      plagerism_count = (select count (*) from flags, ratings 
        where rated_post_id=? and name='plagerized content'
        and ratings.id=flags.rating_id),
      content_count = (select count (*) from flags, ratings 
        where rated_post_id=? and name='offensive content'
        and ratings.id=flags.rating_id),
      image_count = (select count (*) from flags, ratings 
        where rated_post_id=? and name='offensive'
        and ratings.id=flags.rating_id)",
      self.rated_post.id,
      self.rated_post.id,
      self.rated_post.id,
      self.rated_post.id,
      self.rated_post.id,
      self.rated_post.id,
      self.rated_post.id,
      self.rated_post.id,
      self.rated_post.id,
      self.rated_post.id,
      self.rated_post.id,
      self.rated_post.id,
      self.rated_post.id,
      self.rated_post.id, 
      self.rated_post.id,
      self.rated_post.id,
      self.rated_post.id,
      self.rated_post.id,
      self.rated_post.id,
      self.rated_post.id, 
      self.rated_post.id,
      self.rated_post.id,
      self.rated_post.id,
      self.rated_post.id,
      self.rated_post.id,
      self.rated_post.id,
      self.rated_post.id,
      self.rated_post.id,
      self.rated_post.id,
      self.rated_post.id,
      self.rated_post.id,
      self.rated_post.id,
      self.rated_post.id], ['id=?',self.rated_post.id])
  end
end


