class Standard < ActiveRecord::Base
  attr_accessible :ICan, :description, :domain_id, :level_id, :symbol, :short, :url
  has_many :posts
  has_many :videos
  belongs_to :domain
  belongs_to :level
  has_many :lessons
  has_many :assignments
end
