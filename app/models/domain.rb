class Domain < ActiveRecord::Base
  attr_accessible :grade_id, :name, :symbol
  belongs_to :grade
  has_many :standards
  has_many :posts, through: :standards
end
