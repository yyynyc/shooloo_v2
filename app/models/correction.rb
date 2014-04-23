class Correction < ActiveRecord::Base
	attr_accessible :corrected_post_id, :editor_id, :competition, :question, :answer,
		:steps, :level_id, :domain_id, :standard_id, 
		:grammar, :concept_clear, :math_correct, :answer_complete
	belongs_to :corrected_post, class_name: "Post"
	belongs_to :editor, class_name: "User"
	belongs_to :standard
	belongs_to :domain
	belongs_to :level
	validates :corrected_post_id, presence: true, uniqueness: true

	state_machine initial: :draft do
	    after_transition :on => :submit, :do => [:qualify, 
	    	:post_state_transition, :update_editor_stats]

	    event :submit do
	      transition :draft => :submitted
	    end 

	   state :submitted do	   	
      		validates_presence_of  :editor_id, :question, :answer,
				:steps, :level_id, :domain_id, :standard_id, :competition 
			validates :grammar, :concept_clear, :math_correct, :answer_complete, 
				inclusion: [true, false]
		end
	end
       
	def qualify
		if self.corrected_post.competition==1
			if competition == 1 && grammar.true? && concept_clear.true &&
				math_correct.true? && answer_complete.true?
				self.corrected_post.update_attributes!(qualified: yes)
			else
				self.corrected_post.update_attributes!(qualified: no)
			end
			# Activity.create!
		end
	end

	def update_editor_stats
		# self.editor.
	end

	def post_state_transition
		self.corrected_post.verify!
	end
end

