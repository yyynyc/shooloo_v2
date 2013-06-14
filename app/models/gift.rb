class Gift < ActiveRecord::Base
  attr_accessible :choice, :giver_id, :receiver_id, :sent, :week, :year

  belongs_to :giver, class_name: "User"
  belongs_to :receiver, class_name: "User"
end
