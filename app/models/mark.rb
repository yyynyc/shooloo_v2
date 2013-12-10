class Mark < ActiveRecord::Base
  attr_accessible :mark, :bonus, :penalty, :grading_id

  belongs_to :grading

  def full_mark
  	"#{self.mark}#{self.bonus}#{self.penalty}"
  end

  after_create do    
  	if !self.grading.graded_post.nil?
  		post=self.grading.graded_post
      Scorecard.create!(post_id: post.id, color_id: self.mark+1)
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
      Scorecard.create!(comment_id: comment.id, color_id: self.mark+1)
      if !comment.response.nil?
        response = comment.response
        max_mark = response.comments.map(&:mark).sort_by(&:mark).last
  			if Scorecard.where(response_id: response.id).any?
  				Scorecard.find_by_response_id(response.id).update_attributes!(
  					color_id: max_mark.mark+1 )
  			else
  				Scorecard.create!(response_id: response.id,
  				  color_id: max_mark.mark+1)
  			end
  		end
  	end
  end

  after_update do
    if !self.grading.graded_post.nil?
      post=self.grading.graded_post
      Scorecard.find_by_post_id(post.id).update_attributes!(color_id: self.mark+1)
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
      Scorecard.find_by_comment_id(comment.id).update_attributes!(color_id: self.mark+1)
      if !comment.response.nil?
        response = comment.response
        max_mark = response.comments.map(&:mark).sort_by(&:mark).last
        if Scorecard.where(response_id: response.id).any?
          Scorecard.find_by_response_id(response.id).update_attributes!(
            color_id: max_mark.mark+1 )
        else
          Scorecard.create!(response_id: response.id,
            color_id: max_mark.mark+1)
        end
      end
    end
  end
end
