class Mark < ActiveRecord::Base
  attr_accessible :mark, :bonus, :penalty, :grading_id

  belongs_to :grading

  def full_mark
  	"#{self.mark}#{self.bonus}#{self.penalty}"
  end
end
