class Gift < ActiveRecord::Base
  attr_accessible :choice_id, :giver_id, :receiver_id, :sent, :week, :year, 
    :sent_week, :sent_year

  belongs_to :giver, class_name: "User"
  belongs_to :receiver, class_name: "User"
  belongs_to :choice

  after_create do
  	Activity.create!(action: "create", trackable: self, 
		  user_id: self.receiver_id, recipient_id: self.giver_id)
  	Activity.create!(action: "notify", trackable: self, 
		  user_id: self.giver_id, recipient_id: self.receiver_id)
    if self.giver.admin? || self.giver.role == "teacher"
      Activity.create!(action: "sent", trackable: self, 
        user_id: self.giver_id, recipient_id: self.receiver_id)
    end
  end

  after_update do
    if self.sent? 
  	  Activity.create!(action: "sent", trackable: self, 
		    user_id: self.giver_id, recipient_id: self.receiver_id)
    end
  end

  def self.reminder
    Gift.where(sent: nil).where("created_at <=?", Time.now-7.days).each do |g|
      Activity.create!(action: "reminder", trackable: g, 
        user_id: g.receiver_id, recipient_id: g.giver_id)
    end
  end  
end
