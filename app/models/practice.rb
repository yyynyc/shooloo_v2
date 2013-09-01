class Practice < ActiveRecord::Base
  attr_accessible :description, :name, :symbol, :url

  has_many :videos
end
