class Hstandard < ActiveRecord::Base
  attr_accessible :standard_id, :domain_id, :level_id, 
  	:symbol, :short, :url, :ICan, :description, :full_description
  has_many :posts
  has_many :corrections
  has_many :videos
  belongs_to :standard
  belongs_to :domain
  belongs_to :level
  has_many :lessons
  has_many :assignments
  has_many :gradings
  has_many :responses, through: :assignments

  def full_description
    "#{short} - #{description}"
  end

end
