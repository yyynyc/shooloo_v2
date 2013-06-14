class EventsController < ApplicationController
	
	before_filter :signed_in_user

	def gift_receiving
		@user = current_user
		@scores = @user.scores.where(week: Time.now.strftime('%W'), 
        	year: Time.now.strftime('%Y'))
		render 'gift_receiving'
	end

	def gift_giving
		@user = current_user
		@reverse_scores = @user.reverse_scores.where(week: Time.now.strftime('%W'), 
        	year: Time.now.strftime('%Y'))	
		@gifts = @user.gifts.where(week: Time.now.strftime('%W'), 
    		year: Time.now.strftime('%Y'))
		@gifts_sent = @gifts.where(sent: true) 		
		render 'gift_giving'
	end
end


