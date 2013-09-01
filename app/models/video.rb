class Video < ActiveRecord::Base
  attr_accessible :title, :description, :player_loc, :duration, :tags, 
  	:category_id, :practice_id, :standard_id, :thumbnail, :length, :thumbnail_remote_url 
  attr_reader :thumbnail_remote_url

  has_attached_file :thumbnail, 
    :styles => {:small => "180x180>"},            
    url: "/attachments/videos/:id/:style/:basename.:extension",
    path: ":rails_root/public/attachments/videos/:id/:style/:basename.:extension"

  belongs_to :category
  belongs_to :practice
  belongs_to :standard

  def thumbnail_remote_url=(url_value) 
    return if url_value.blank?
    self.thumbnail = URI.parse(url_value)
    @thumbnail_remote_url = url_value
    url = URI(url_value)  
  end
end
