class Correction < ActiveRecord::Base
	attr_accessible :corrected_post_id, :editor_id, :competition, :question, :answer,
		:steps, :level_id, :domain_id, :standard_id, :hstandard_id,
		:grammar, :concept_clear, :math_correct, :answer_complete, :state, :author_views, :other_views
	belongs_to :corrected_post, class_name: "Post"
	belongs_to :editor, class_name: "User"
	belongs_to :hstandard
	belongs_to :standard
	belongs_to :domain
	belongs_to :level
	validates :corrected_post_id, presence: true, uniqueness: true

	state_machine initial: :draft do
	    after_transition :on => :submit, :do => [:qualify, :update_pub_credits, :update_toreview,
	    	:post_state_transition, :update_editor_stats, :update_post_characters]
	    after_transition :on => :revise, :do => [:qualify, :revise_pubcred_post_characters] 

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

	def update_toreview
		corrected_post.update_attributes!(toreview: true)
	end
       
	def qualify
		if self.corrected_post.competition==1
			if self.competition == 1 && self.grammar? && self.concept_clear? &&
				self.math_correct? && self.answer_complete? && self.steps > 1 &&
				self.corrected_post.user.grade <= (self.level.number+1)
				if self.corrected_post.qualified == "no"
					self.corrected_post.user.point.qualified += 1
					self.corrected_post.user.point.disqualified -= 1
					self.corrected_post.user.point.save
					self.corrected_post.user.authorizers.each do |a|
						a.point.inspiration += ShoolooV2::TEACHER_INSPIRATION
						a.point.save
	        			a.student_contest.qualified_total += 1
	        			a.student_contest.disqualified_total -= 1
	     				a.student_contest.save
	     				Activity.create!(action: "notify", trackable: self.corrected_post, 
        					user_id: self.corrected_post.user_id, recipient_id: a.id, position: 3)
					end
					self.corrected_post.update_attributes!(qualified: "yes")
				elsif self.corrected_post.qualified.nil?
					self.corrected_post.user.point.qualified += 1
					self.corrected_post.user.point.save
					self.corrected_post.user.authorizers.each do |a|
						a.point.inspiration += ShoolooV2::TEACHER_INSPIRATION
						a.point.save
	        			a.student_contest.qualified_total += 1
	     				a.student_contest.save
	     				Activity.create!(action: "notify", trackable: self.corrected_post, 
        					user_id: self.corrected_post.user_id, recipient_id: a.id, position: 3)
					end
					self.corrected_post.update_attributes!(qualified: "yes")
				end
			else
				if self.corrected_post.qualified == "yes"
					self.corrected_post.user.point.disqualified += 1
					self.corrected_post.user.point.qualified -= 1
					self.corrected_post.user.point.save
					self.corrected_post.user.authorizers.each do |a|
						a.point.inspiration -= ShoolooV2::TEACHER_INSPIRATION
						a.point.save
	        			a.student_contest.disqualified_total += 1
	        			a.student_contest.qualified_total -= 1
	     				a.student_contest.save
	     				Activity.where(action: "notify", trackable_type: "Post", trackable_id: self.corrected_post.id, 
        					user_id: self.corrected_post.user_id, recipient_id: a.id).delete_all
					end
					self.corrected_post.update_attributes!(qualified: "no")
				elsif self.corrected_post.qualified.nil?
					self.corrected_post.user.point.disqualified += 1
					self.corrected_post.user.point.save
					self.corrected_post.user.authorizers.each do |a|
	        			a.student_contest.disqualified_total += 1
	     				a.student_contest.save
					end
					self.corrected_post.update_attributes!(qualified: "no")
				end
			end
			Activity.create!(action: "qualify", trackable: self.corrected_post, 
        		user_id: 1, recipient_id: self.corrected_post.user_id, position: 3)
		else			
			Activity.create!(action: "publish", trackable: self.corrected_post, 
        			user_id: 1, recipient_id: self.corrected_post.user_id, position: 1)
		end
	end

	def update_pub_credits
		unless self.corrected_post.grandfather?
			if self.corrected_post.user.grade <= self.level.number
				self.corrected_post.user.pubcred += ShoolooV2::AT_GRADE
				self.corrected_post.user.save(validate: false)
				Activity.create!(action: "at_grade", trackable: self.corrected_post, 
	        		user_id: 1, recipient_id: self.corrected_post.user_id, position: 2)
			else
				# self.corrected_post.user.pubcred -= (ShoolooV2::BELOW_GRADE)*(self.corrected_post.user.grade - self.level.number)
				# self.corrected_post.user.save(validate: false)
				Activity.create!(action: "below_grade", trackable: self.corrected_post, 
	        		user_id: 1, recipient_id: self.corrected_post.user_id, position: 2)
			end
		end
	end

	def update_post_characters
	    self.corrected_post.update_attributes!(steps: self.steps, 
	      level_id: self.level_id, 
	      domain_id: self.domain_id,
	      standard_id: self.standard_id, 
	      hstandard_id: self.hstandard_id)
	end

	def revise_pubcred_post_characters
		unless self.corrected_post.grandfather?
			if self.corrected_post.level.number < self.corrected_post.user.grade
				if self.level.number >= self.corrected_post.user.grade
					self.corrected_post.user.pubcred += ((ShoolooV2::BELOW_GRADE)*(self.corrected_post.user.grade - self.corrected_post.level.number) + ShoolooV2::AT_GRADE)        
					self.corrected_post.user.save(validate: false)
					alerts = Activity.where(action: "below_grade", trackable_type: "Post", 
						trackable_id: self.corrected_post.id, user_id: 1, recipient_id: self.corrected_post.user_id)
					if !alerts.blank?
	        			alerts.each {|a| a.destroy} 
	        		end
	        		Activity.create!(action: "at_grade", trackable: self.corrected_post, 
	        		user_id: 1, recipient_id: self.corrected_post.user_id)
				end
			elsif self.corrected_post.level.number >= self.corrected_post.user.grade
				if self.level.number < self.corrected_post.user.grade
					self.corrected_post.user.pubcred -= ((ShoolooV2::BELOW_GRADE)*(self.corrected_post.user.grade - self.corrected_post.level.number) + ShoolooV2::AT_GRADE)
					self.corrected_post.user.save(validate: false)
					alerts = Activity.where(action: "at_grade", trackable_type: "Post", 
						trackable_id: self.corrected_post.id, user_id: 1, recipient_id: self.corrected_post.user_id)
					if !alerts.blank?
	        			alerts.each {|a| a.destroy} 
	        		end
	        		Activity.create!(action: "below_grade", trackable: self.corrected_post, 
	        		user_id: 1, recipient_id: self.corrected_post.user_id)
				end
			end
		end
		post = self.corrected_post
		post.update_attributes(steps: self.steps, 
	      level_id: self.level_id, 
	      domain_id: self.domain_id,
	      standard_id: self.standard_id, 
	      hstandard_id: self.hstandard_id)
		post.save(validate: false)
	end

	def update_editor_stats
		self.editor.correction_count = self.editor.corrections.count
		self.editor.save(validate: false)
	end

	def post_state_transition
		self.corrected_post.verify!
	end

	after_destroy do 
		Activity.where(trackable_type: "Post", trackable_id: self.corrected_post.id).delete_all
	end
end

