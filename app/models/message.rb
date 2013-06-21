class Message < ActiveRecord::Base

  attr_accessible :body, :email, :name, :subject, :recaptcha
  validates_presence_of :body, :email, :name, :subject
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, allow_blank: true, format: { with: VALID_EMAIL_REGEX } 
end
