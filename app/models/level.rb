class Level < ActiveRecord::Base
  attr_accessible :name, :number
  has_many :domains
  has_many :standards, through: :domains
  has_many :posts, through: [:domains, :standards]
end
