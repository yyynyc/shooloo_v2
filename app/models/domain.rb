class Domain < ActiveRecord::Base
  attr_accessible :level_id, :name, :symbol, :core
  belongs_to :level
  has_many :standards
  has_many :posts, through: [:standards, :hstandards]
  has_many :corrections, through: [:standards, :hstandards]
  has_many :lessons, through: [:standards, :hstandards]
  has_many :assignments, through: [:standards, :hstandards]
  has_many :gradings, through: [:standards, :hstandards]
  has_many :responses, through: :assignments
end
