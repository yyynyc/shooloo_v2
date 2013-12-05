class Color < ActiveRecord::Base
   attr_accessible :value, :code, :weakness

   has_many :scorecards
   has_many :responses, through: :scorecards
end
