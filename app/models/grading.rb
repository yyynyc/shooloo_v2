class Grading < ActiveRecord::Base
  attr_accessible :bonus, :graded_comment_id, :mark, :penalty, :note, 
  :graded_post_id, :grader_id, :level_id, :domain_id, :standard_id,
  :concept, :precision, :computation, :grammar, :courtesy

  belongs_to :graded_post, class_name: "Post"
  belongs_to :graded_comment, class_name: "Comment"
  belongs_to :grader, class_name: "User"
  belongs_to :level
  belongs_to :domain
  belongs_to :standard
  has_one :mark, dependent: :destroy

  after_create do
  	if self.concept == false
  		mark = Mark.create(mark: 1, grading_id: self.id)
  	elsif self.precision == false
  		mark = Mark.create(mark: 2, grading_id: self.id)
  	elsif self.computation == false
  		mark = Mark.create(mark: 3, grading_id: self.id)
  	else
  		mark = Mark.create(mark: 4, grading_id: self.id)
  	end

  	if self.grammar == true
  		mark.bonus = "+"
  	end 

  	if self.courtesy == false
  		mark.penalty = "-"
  	end 

  	mark.save!

  	if !self.graded_post_id.nil? 
  		if self.graded_post.level_id > self.level_id
        if !self.graded_post.response.nil?
          self.graded_post.response.update_attributes!(completed: false)
        end
  			self.graded_post.update_attributes!(level_id: self.level_id, response_id: nil)
  			# Activity.create!(action: "zero", trackable: self, 
    	# 	user_id: self.grader_id, recipient_id: self.post.user_id)
      elsif self.graded_post.level_id < self.level_id
        self.graded_post.update_attributes!(level_id: self.level_id, response_id: nil)
  		elsif self.graded_post.domain_id != self.domain_id
  			self.graded_post.update_attributes!(domain_id: self.domain_id)
  		elsif self.graded_post.standard_id != self.standard_id
  			self.graded_post.update_attributes!(standard_id: self.standard_id)
  		end
  		# Activity.create!(action: "post", trackable: self, 
    # 		user_id: self.grader_id, recipient_id: self.post.user_id)
  	elsif
  		!self.graded_comment_id.nil?
  		# Activity.create!(action: "comment", trackable: self, 
    # 		user_id: self.grader_id, recipient_id: self.comment.commenter_id)
  	end
  end

  after_update do
    if self.concept == false
      mark = self.mark.update_attributes!(mark: 1)
    elsif self.precision == false
      mark = self.mark.update_attributes!(mark: 2)
    elsif self.computation == false
      mark = self.mark.update_attributes!(mark: 3)
    else
      mark = self.mark.update_attributes!(mark: 4)
    end

    if self.grammar == true
      self.mark.bonus = "+"
    end 

    if self.courtesy == false
      self.mark.penalty = "-"
    end 

    self.mark.save!

    if !self.graded_post_id.nil? 
      if self.graded_post.level_id > self.level_id
        if !self.graded_post.response.nil?
          self.graded_post.response.update_attributes!(completed: false)
        end
        self.graded_post.update_attributes!(level_id: self.level_id, response_id: nil)
        # Activity.create!(action: "zero", trackable: self, 
      #   user_id: self.grader_id, recipient_id: self.post.user_id)
      elsif self.graded_post.level_id < self.level_id
        self.graded_post.update_attributes!(level_id: self.level_id, response_id: nil)
      elsif self.graded_post.domain_id != self.domain_id
        self.graded_post.update_attributes!(domain_id: self.domain_id)
      elsif self.graded_post.standard_id != self.standard_id
        self.graded_post.update_attributes!(standard_id: self.standard_id)
      end
      # Activity.create!(action: "post", trackable: self, 
    #     user_id: self.grader_id, recipient_id: self.post.user_id)
    elsif
      !self.graded_comment_id.nil?
      # Activity.create!(action: "comment", trackable: self, 
    #     user_id: self.grader_id, recipient_id: self.comment.commenter_id)
    end
  end

  after_destroy do
  	Mark.where(grading_id: self.id).delete_all
  end
end
