class Score < ActiveRecord::Base
  attr_accessible :benefactor_id, :beneficiary_id, :year, :week, :weekly_tally
  belongs_to :benefactor, class_name: "User"
  belongs_to :beneficiary, class_name: "User" 
end
