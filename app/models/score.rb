class Score < ActiveRecord::Base
  attr_accessible :benefactor_id, :beneficiary_id, :year, :week, :weekly_tally
  belongs_to :benefactor, class_name: "User"
  belongs_to :beneficiary, class_name: "User" 

  	after_update do
	  if self.weekly_tally >= ShoolooV2::GIFT_THRESHOLD && 
	  	Gift.where(week: self.week, year: self.year,
	  		receiver_id: self.benefactor_id, 
	  		giver_id: self.beneficiary_id).blank?
	  	Gift.create!(week: self.week, year: self.year,
			receiver_id: self.benefactor_id, 
	  		giver_id: self.beneficiary_id)
	  end
	end

	def progress
		100.0 * (self.weekly_tally / ShoolooV2::GIFT_THRESHOLD)
	end
end
