class Point < ActiveRecord::Base
  attr_accessible :advocacy, :education, :inspiration, :user_id, :competition,
  	:qualified, :disqualified
  belongs_to :user
end
