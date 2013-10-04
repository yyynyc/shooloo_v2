class Homework < ActiveRecord::Base
  attr_accessible :comment_count, :post_count, :user_id, :week, :year
  belongs_to :users
end
