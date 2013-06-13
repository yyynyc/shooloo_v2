class EventsController < ApplicationController
	def gift_receiving
		@user = current_user
		@post = Post.new
		@score = Score.find_by_benefactor_id(@user.id)
		render 'gift_receiving'
	end
end
