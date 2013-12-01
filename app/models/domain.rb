class Domain < ActiveRecord::Base
  attr_accessible :level_id, :name, :symbol, :core
  belongs_to :level
  has_many :standards
  has_many :posts, through: :standards
  has_many :lessons, through: :standards
  has_many :assignments, through: :standards
end
