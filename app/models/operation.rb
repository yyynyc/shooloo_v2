# == Schema Information
#
# Table name: operations
#
#  id         :integer          not null, primary key
#  name       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  rating_id  :integer
#

class Operation < ActiveRecord::Base
  attr_accessible :rating_id, :name
  belongs_to :rating
end