class Keep < ActiveRecord::Base
  attr_accessible :keeper_id, :kept_post_id, :note

  belongs_to :keeper, class_name: "User"
  belongs_to :kept_post, class_name: "Post"
end
