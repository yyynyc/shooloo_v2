class Post < ActiveRecord::Base
  attr_accessible :answer, :grade, :question
  belongs_to :user

  validates :user_id, presence: true
  validates :question, presence: true
  validates :answer, presence: true, length: {maximum: 100}
  validates :grade, presence: true
  default_scope order: 'posts.created_at DESC'

  # Returns posts from the users being followed by the given user.
  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", 
          user_id: user.id)
  end
end
