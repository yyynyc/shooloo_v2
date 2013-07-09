class Standard < ActiveRecord::Base
  attr_accessible :ICan, :description, :domain_id, :grade_id, :symbol
  has_many :posts
  belongs_to :domain
  belongs_to :grade
end
