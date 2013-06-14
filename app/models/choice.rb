class Choice < ActiveRecord::Base
  attr_accessible :gift_id, :image, :name, :user_id, :visible

  has_attached_file :image, 
    :styles => {:large => "1000x1000>",
                :small => "100x100>"},                
    url: "/attachments/choices/:id/:style/:basename.:extension",
    path: ":rails_root/public/attachments/choices/:id/:style/:basename.:extension"

  has_many :gifts, dependent: :destroy, order: "updated_at DESC"
  belongs_to :user
end
