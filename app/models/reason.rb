class Reason < ActiveRecord::Base
  attr_accessible :name, :position, :alarm_id
  belongs_to :alarm
end
