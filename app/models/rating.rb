class Rating < ActiveRecord::Base
  attr_accessible :rated_post_id, :answer_correctness, :steps,  
	   :improvement_ids, :overall_rating, :ccss_suitability 

  belongs_to :rated_post, class_name: "Post"
  belongs_to :rater, class_name: "User"

  has_many :operations, order: "position"
  accepts_nested_attributes_for :operations
  has_many :improvements, order: "position"
  accepts_nested_attributes_for :improvements
  has_many :flags, order: "position"
  accepts_nested_attributes_for :flags 

  validates_presence_of :rated_post_id, :rater_id, :answer_correctness, 
    :steps, :ccss_suitability
  validates_inclusion_of :overall_rating, in: [true, false]

  default_scope order: 'ratings.updated_at DESC'

  after_create do
    update_rating_counts
    Activity.create!(action: "create", trackable: self, 
      user_id: self.rater_id, recipient_id: self.rated_post.user_id)
    Event.create!(benefactor_id: self.rater_id, 
      beneficiary_id: self.rated_post.user_id, 
      event: "new rating", value: ShoolooV2::RATING_NEW)
    if self.rated_post.raters.count > 1
      self.rated_post.raters.uniq.each do |r|
        Activity.create!(action: "create", trackable: self, 
          user_id: self.rater_id, recipient_id: r.id)
      end
    end
  end
  
  after_destroy do
    update_rating_counts
    Event.create!(benefactor_id: self.rater_id, 
      beneficiary_id: self.rated_post.user_id, 
      event: "delete rating", value: ShoolooV2::RATING_DELETE)
  end

  def update_rating_counts
    Post.update_all([
      "ratings_count = (select count (*) from ratings 
        where rated_post_id=?),
      overall_true_count = (select count (*) from ratings 
        where rated_post_id=? and overall_rating='true'),
      overall_false_count = (select count (*) from ratings 
        where rated_post_id=? and overall_rating='false'),
      ccss_wrong_grade_count = (select count (*) from ratings 
        where rated_post_id=? and ccss_suitability=1),
      ccss_right_count = (select count (*) from ratings 
        where rated_post_id=? and ccss_suitability=2),
      ccss_wrong_skill_count = (select count (*) from ratings 
        where rated_post_id=? and ccss_suitability=3),
      ccss_wrong_ican_count = (select count (*) from ratings 
        where rated_post_id=? and ccss_suitability=4),
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
        and ratings.id=improvements.rating_id)",
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


