class Mark < ActiveRecord::Base
  attr_accessible :mark, :bonus, :penalty, :grading_id

  belongs_to :grading

  def full_mark
  	"#{self.mark}#{self.bonus}#{self.penalty}"
  end

  after_create do
  	if !self.grading.graded_post.nil?
  		post=self.grading.graded_post
  		if !post.response.nil?
  			response = post.response
  			if Scorecard.where(response_id: response.id).any?
  				Scorecard.find_by_response_id(response.id).update_attributes!(
  					color_id: response.marks.max.mark+1 )
  			else
  				Scorecard.create!(response_id: response.id,
  				color_id: response.marks.max.mark+1)
  			end
  		end
  	else
  		comment = self.grading.graded_comment
  		if !comment.response.nil?
  		response = comment.response
  			if Scorecard.where(response_id: response.id).any?
  				Scorecard.find_by_response_id(response.id).update_attributes!(
  					color_id: response.marks.max.mark+1 )
  			else
  				Scorecard.create!(response_id: response.id,
  				color_id: response.marks.max.mark+1)
  			end
  		end
  	end
  end
end
