class EventsController < ApplicationController
	
	before_filter :signed_in_user

	def gift_receiving
		@user = current_user
		@scores = @user.scores.where(week: Time.now.strftime('%W'), 
        	year: Time.now.strftime('%Y')).order('weekly_tally DESC')
		@received_gifts = @user.reverse_gifts.where(week: Time.now.strftime('%W'), 
        	year: Time.now.strftime('%Y'), sent: true)
		render 'gift_receiving'
	end

	def gift_giving
		@user = current_user
		@gifts_unsent = @user.gifts.where(sent: nil).order('created_at DESC')
		@choices_visible = Choice.where(visible: true)
		@reverse_scores = @user.reverse_scores.where(week: Time.now.strftime('%W'), 
        	year: Time.now.strftime('%Y')).order('weekly_tally ASC')	
		@gifts_current_week = @user.gifts.where(week: Time.now.strftime('%W'), 
    		year: Time.now.strftime('%Y'))		 		
		render 'gift_giving'
	end
end


