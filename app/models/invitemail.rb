class Invitemail < ActiveRecord::Base
  attr_accessible :body, :subject, :to, :user_id
  belongs_to :user

  validates :to, presence: true

  after_create do
  	UserMailer.invite_mail(self).deliver
  end
end
