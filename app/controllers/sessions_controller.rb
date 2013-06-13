class SessionsController < ApplicationController
	def new
	end

	def create
		user = User.find_by_screen_name(params[:session][:screen_name])
    	if user && user.authenticate(params[:session][:password])
      		sign_in user
      		
      		redirect_back_or my_alerts_path
          unless user.admin? || 
            Event.where(benefactor_id: user.id, event: "sign in").where(
              'Date(created_at)=?', Date.today).any?
      		  Event.create!(benefactor_id: user.id, beneficiary_id: 2, 
        		  event: "sign in", value: ShoolooV2::SIGN_IN)
            flash[:success] = "Welcome back! You've just earned some points! 
            You are one step closer towarding getting a gift."
          end
    	else
      		flash.now[:error] = "Invalid screen name/password combination"
      		render 'new'
    	end
	end

	def destroy
		sign_out
		redirect_to root_url
	end
end
