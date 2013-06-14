class GiftsController < ApplicationController

	before_filter :signed_in_user
	
	def update
		@gift = Gift.find(params[:id])
		@user = @gift.receiver
	    current_user.gifts.find_by_receiver_id(@user.id).update_attributes!(params[:gift])  
	    respond_to do |format|
	        format.html {redirect_to gift_giving_path}
	        format.js
      	end	
    end
end