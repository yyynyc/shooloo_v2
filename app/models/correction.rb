class Correction < ActiveRecord::Base
	attr_accessible :corrected_post_id, :editor_id, :competition, :question, :answer,
		:steps, :level_id, :domain_id, :standard_id, 
		:grammar, :concept_clear, :math_correct, :answer_complete
	belongs_to :corrected_post, class_name: "Post"
	belongs_to :editor, class_name: "User"
	belongs_to :standard
	belongs_to :domain
	belongs_to :level

	validates_presence_of :corrected_post_id, :editor_id, :question, :answer,
		:steps, :level_id, :domain_id, :standard_id, :competition 
	validates :grammar, :concept_clear, :math_correct, :answer_complete, 
		inclusion: [true, false]
end

