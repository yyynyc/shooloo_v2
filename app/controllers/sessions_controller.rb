class SessionsController < ApplicationController
	def new
	end

	def create
		user = User.find_by_screen_name(params[:session][:screen_name])
    	if user && user.authenticate(params[:session][:password])
      		sign_in user
      		redirect_back_or my_alerts_path
    	else
      		flash.now[:error] = 'Invalid screen name/password combination'
      		render 'new'
    	end
	end

	def destroy
		sign_out
		redirect_to root_url
	end
end
