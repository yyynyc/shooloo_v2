class GiftsController < ApplicationController

	before_filter :signed_in_user
	
	def update
		@gift = Gift.find(params[:id])
		@user = @gift.receiver
	    current_user.gifts.find_by_receiver_id(@user.id).update_attributes!(params[:gift]) 
	    current_user.gift_sent_count += 1
	    current_user.save
	    sign_in current_user
	    @user.gift_received_count += 1
	    @user.save 
	    respond_to do |format|
	        format.html {redirect_to gift_giving_path}
	        format.js
      	end	
    end

    def destroy
    	@gift = Gift.find(params[:id])
		@sender = @gift.sender
		current_user.gift_received_count -= 1
	    current_user.save
	    sign_in current_user
	    @sender.gift_sent_count -= 1
	    @sender.save 
    end
end