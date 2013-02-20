# == Schema Information
#
# Table name: flags
#
#  id         :integer          not null, primary key
#  name       :text
#  rating_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  position   :integer
#

class Flag < ActiveRecord::Base
	attr_accessible :rating_id, :name
  	belongs_to :rating
  	acts_as_list scope: :rating
end
