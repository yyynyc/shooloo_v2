class Post < ActiveRecord::Base
  attr_accessible :answer, :grade, :question
  belongs_to :user

  validates :user_id, presence: true
end
