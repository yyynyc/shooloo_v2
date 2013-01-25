class AddPhotoToPosts < ActiveRecord::Migration
 def self.up
  	add_attachment :posts, :photo
 end

 def self.down
  	remove_attachment :posts, :photo
 end
end
