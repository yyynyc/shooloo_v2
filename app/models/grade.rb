class Grade < ActiveRecord::Base
  # attr_accessible :title, :body

  has_many :responses
end
