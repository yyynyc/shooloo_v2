class AddVideoFilesToVideos < ActiveRecord::Migration
	def self.up
	  	add_attachment :videos, :video_mp4
	  	add_attachment :videos, :video_ogv
	  	add_attachment :videos, :video_webm
	end

	def self.down
	  	remove_attachment :videos, :video_mp4
	  	remove_attachment :videos, :video_ogv
	  	remove_attachment :videos, :video_webm
	end
end
