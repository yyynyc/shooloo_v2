class Grading < ActiveRecord::Base
  attr_accessible :bonus, :comment_id, :mark, 
  :post_id, :grader_id, :level_id, :domain_id, :standard_id,
  :concept, :precision, :computation, :grammar, :courtesy

  belongs_to :post
  belongs_to :comment
  belongs_to :grader, class_name: "User"
  belongs_to :level
  belongs_to :domain
  belongs_to :standard
end
