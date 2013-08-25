class Score < ActiveRecord::Base
  attr_accessible :benefactor_id, :beneficiary_id, :year, :week, :weekly_tally
  belongs_to :benefactor, class_name: "User"
  belongs_to :beneficiary, class_name: "User" 

  	after_save do
	  if self.weekly_tally >= ShoolooV2::GIFT_THRESHOLD && 
	  	Gift.where(week: self.week, year: self.year,
	  		receiver_id: self.benefactor_id, 
	  		giver_id: self.beneficiary_id).blank?
	  	if self.beneficiary_id == 1 
	  		g=Gift.create!(week: self.week, year: self.year,
				receiver_id: self.benefactor_id, 
	  			giver_id: 1, 
	  			choice_id: 1, sent: true)
	  		g.save!
	  	elsif self.beneficiary_id == 2 
	  		g=Gift.create!(week: self.week, year: self.year,
				receiver_id: self.benefactor_id, 
	  			giver_id: 2, 
	  			choice_id: 3, sent: true)
	  		g.save!
	  	elsif self.beneficiary.role == "teacher"
	  		g=Gift.create!(week: self.week, year: self.year,
				receiver_id: self.benefactor_id, 
	  			giver_id: self.beneficiary_id, 
	  			choice_id: 2, sent: true)
	  		g.save!
	  	else 
	  		Gift.create!(week: self.week, year: self.year,
				receiver_id: self.benefactor_id, 
	  			giver_id: self.beneficiary_id)
	  	end
	  end
	end

	def progress
		100.0 * (self.weekly_tally / ShoolooV2::GIFT_THRESHOLD)
	end
end
