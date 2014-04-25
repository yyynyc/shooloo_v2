class Level < ActiveRecord::Base
  attr_accessible :name, :number
  has_many :domains
  has_many :standards, through: :domains
  has_many :posts, through: [:domains, :standards, :hstandards]
  has_many :corrections, through: [:domains, :standards, :hstandards]
  has_many :lessons, through: [:domains, :standards, :hstandards]
  has_many :assignments, through: [:domains, :standards, :hstandards]
  has_many :gradings, through: [:domains, :standards, :hstandards]
  has_many :responses, through: :assignments
end
