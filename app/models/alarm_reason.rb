class AlarmReason < ActiveRecord::Base
  attr_accessible :alarm_id, :reason_id
  belongs_to :alarm
  belongs_to :reason
  accepts_nested_attributes_for :reason
  validates_presence_of :alarm
  validates_presence_of :reason
end
