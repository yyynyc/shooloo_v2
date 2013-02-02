# == Schema Information
#
# Table name: ratings
#
#  id            :integer          not null, primary key
#  rater_id      :string(255)
#  rated_post_id :string(255)
#  value         :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Rating < ActiveRecord::Base
  attr_accessible :rated_post_id, :value

  belongs_to :rated_post, class_name: "Post"
  belongs_to :rater, class_name: "User"

  validates :rated_post_id, presence: true
  validates :rater_id, presence: true
  validates :value, presence: true
end
