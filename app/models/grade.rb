class Grade < ActiveRecord::Base
  attr_accessible :number, :name
  has_many :domains
  has_many :standards, through: :domains
  has_many :posts, through: [:domains, :standards]
end
