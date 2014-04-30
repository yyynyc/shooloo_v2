class Correction < ActiveRecord::Base
	attr_accessible :corrected_post_id, :editor_id, :competition, :question, :answer,
		:steps, :level_id, :domain_id, :standard_id, :hstandard_id,
		:grammar, :concept_clear, :math_correct, :answer_complete
	belongs_to :corrected_post, class_name: "Post"
	belongs_to :editor, class_name: "User"
	belongs_to :hstandard
	belongs_to :standard
	belongs_to :domain
	belongs_to :level
	validates :corrected_post_id, presence: true, uniqueness: true

	state_machine initial: :draft do
	    after_transition :on => :submit, :do => [:qualify, :update_pub_credits,
	    	:post_state_transition, :update_editor_stats]

	    event :submit do
	      transition :draft => :submitted
	    end 

	    event :revise do
	      transition [:draft, :submitted, :revised] => :revised
	    end

	   state :submitted, :revised do	   	
      		validates_presence_of  :editor_id, :question, :answer,
				:steps, :level_id, :domain_id, :standard_id, :competition 
			validates :grammar, :concept_clear, :math_correct, :answer_complete, 
				inclusion: [true, false]
			validates_presence_of :hstandard_id, if: "level_id==10"
		end
	end
       
	def qualify
		if self.corrected_post.competition==1
			if self.competition == 1 && self.grammar? && self.concept_clear? &&
				self.math_correct? && self.answer_complete? && 
				self.corrected_post.user.grade <= self.level.number	
				self.corrected_post.update_attributes!(qualified: "yes")
				self.corrected_post.user.point.qualified +=1
				self.corrected_post.user.point.save
				self.corrected_post.user.authorizers.each do |a|
					a.point.inspiration += ShoolooV2::TEACHER_INSPIRATION
					a.point.save
        			a.student_contest.qualified_total += 1
     				a.student_contest.save
				end
			else
				self.corrected_post.update_attributes!(qualified: "no")
				self.corrected_post.user.point.disqualified +=1
				self.corrected_post.user.point.save
				self.corrected_post.user.authorizers.each do |a|
        			a.student_contest.disqualified_total += 1
     				a.student_contest.save
				end
			end
			Activity.create!(action: "qualify", trackable: self.corrected_post, 
        		user_id: 1, recipient_id: self.corrected_post.user_id)
		else
			unless self.corrected_post.grandfather?
				Activity.create!(action: "publish", trackable: self.corrected_post, 
        			user_id: 1, recipient_id: self.corrected_post.user_id)
			end
		end
	end

	def update_pub_credits
		unless self.corrected_post.grandfather?
			if self.corrected_post.user.grade <= self.level.number
				self.corrected_post.user.pubcred += ShoolooV2::AT_GRADE
				self.corrected_post.user.save(validate: false)
				Activity.create!(action: "at_grade", trackable: self.corrected_post, 
	        		user_id: 1, recipient_id: self.corrected_post.user_id)
			else
				self.corrected_post.user.pubcred -= (ShoolooV2::BELOW_GRADE)*(self.corrected_post.user.grade - self.level.number)
				self.corrected_post.user.save(validate: false)
				Activity.create!(action: "below_grade", trackable: self.corrected_post, 
	        		user_id: 1, recipient_id: self.corrected_post.user_id)
			end
		end
	end

	def update_editor_stats
		self.editor.correction_count += 1
		self.editor.save(validate: false)
	end

	def post_state_transition
		self.corrected_post.verify!
	end
end

