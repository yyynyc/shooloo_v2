class Practice < ActiveRecord::Base
  attr_accessible :description, :name, :symbol, :url

  has_many :videos
  has_many :lessons
end
