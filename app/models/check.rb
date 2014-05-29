class Check < ActiveRecord::Base
  attr_accessible :checked_post_id, :checker_id
  belongs_to :checked_post, class_name: "Post"
  belongs_to :checker, class_name: "User"
end
