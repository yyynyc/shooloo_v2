class Scorecard < ActiveRecord::Base
  attr_accessible :response_id, :color_id

  belongs_to :response
  belongs_to :color
end
