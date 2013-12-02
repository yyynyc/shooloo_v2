class GiftsController < ApplicationController

	before_filter :signed_in_user
	
	def update
		@gift = Gift.find(params[:id])
		@user = @gift.receiver
	    current_user.gifts.find_by_receiver_id(@user.id).update_attributes!(params[:gift]) 
	    if current_user.gift_sent_count.nil?
	    	current_user.gift_sent_count = 0
	    end
	    current_user.gift_sent_count += 1
	    current_user.save(validate: false)
	    sign_in current_user
	    if @user.gift_received_count.nil?
	    	@user.gift_received_count = 0
	    end
	    @user.gift_received_count += 1
	    @user.save(validate: false) 
	    respond_to do |format|
	        format.html {redirect_to gift_giving_path}
	        format.js
      	end	
    end

    def destroy
    	@gift = Gift.find(params[:id])
		@sender = @gift.sender
		current_user.gift_received_count -= 1
	    current_user.save(validate: false)
	    sign_in current_user
	    @sender.gift_sent_count -= 1
	    @sender.save(validate: false) 
    end
end