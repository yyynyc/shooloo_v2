class StudentContest < ActiveRecord::Base
  attr_accessible :disqualified_total, :entry_total, :qualified_total, :user_id
  belongs_to :user
end
