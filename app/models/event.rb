class Event < ActiveRecord::Base
  attr_accessible :benefactor_id, :beneficiary_id, :event, :value

  belongs_to :benefactor, class_name: "User"
  belongs_to :beneficiary, class_name: "User"

  def week
  	self.created_at.strftime('%W')
  end

  after_create do
  	if Score.where(week: self.week, benefactor_id: self.benefactor_id, 
  		beneficiary_id: self.beneficiary_id).any?
  		s = Score.find_by_week_and_benefactor_id_and_beneficiary_id(
  			self.week, self.benefactor_id, self.beneficiary_id)
  		s.weekly_tally += self.value
  		s.save!
	else
		Score.create!(week: self.week, benefactor_id: self.benefactor_id, 
  		beneficiary_id: self.beneficiary_id, weekly_tally: self.value)
	end
  end
end