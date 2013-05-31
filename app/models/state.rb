class State < ActiveRecord::Base
  attr_accessible :complete, :user_id
  belongs_to :user
end
