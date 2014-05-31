class Reason < ActiveRecord::Base
  attr_accessible :name, :position, :alarm_id
  has_many :alarm_reasons
  has_many :alarms, through: :alarm_reasons
end
