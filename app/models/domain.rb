class Domain < ActiveRecord::Base
  attr_accessible :level_id, :name, :symbol, :core
  belongs_to :level
  has_many :standards
  has_many :posts, through: :standards
end
