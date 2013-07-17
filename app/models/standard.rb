class Standard < ActiveRecord::Base
  attr_accessible :ICan, :description, :domain_id, :level_id, :symbol, :short, :url
  has_many :posts
  belongs_to :domain
  belongs_to :level
end