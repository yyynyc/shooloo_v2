class Relationship < ActiveRecord::Base
  attr_accessible :followed_id

  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

  validates :follower_id, presence: true
  validates :followed_id, presence: true

  after_create do
    Activity.create!(action: "create", trackable: self, user_id: self.follower_id, recipient_id: self.followed_id)
  end


end
