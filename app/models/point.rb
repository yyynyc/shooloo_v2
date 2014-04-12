class Point < ActiveRecord::Base
  attr_accessible :advocacy, :education, :inspiration, :user_id, :competition
  belongs_to :user
end
