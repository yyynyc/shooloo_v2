class Scorecard < ActiveRecord::Base
  attr_accessible :response_id, :color_id, :comment_id, :post_id

  belongs_to :response
  belongs_to :color
  belongs_to :comment
  belongs_to :post
end
