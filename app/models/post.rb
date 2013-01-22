class Post < ActiveRecord::Base
  attr_accessible :answer, :grade, :question
  belongs_to :user

  validates :user_id, presence: true
  validates :question, presence: true
  validates :answer, presence: true, length: {maximum: 100}
  validates :grade, presence: true
  default_scope order: 'posts.created_at DESC'
end
