# == Schema Information
#
# Table name: improvements
#
#  id         :integer          not null, primary key
#  name       :text
#  rating_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Improvement < ActiveRecord::Base
    attr_accessible :rating_id, :name
  	belongs_to :rating
end
