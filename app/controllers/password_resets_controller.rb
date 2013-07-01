class PasswordResetsController < ApplicationController
	def new  	
	end

  	def create
	  user = User.find_by_screen_name(params[:screen_name])
	  user.send_password_reset if user
	  redirect_to root_url, :notice => "Password reset instruction has been sent to your personal email address on file."
	end

	def edit
	  @user = User.find_by_password_reset_token!(params[:id])
	end

	def update
	  @user = User.find_by_password_reset_token!(params[:id])
	  if @user.password_reset_sent_at < 6.hours.ago
	    redirect_to new_password_reset_path, :alert => "Password reset has expired."
	  elsif @user.update_attributes(params[:user])
	    redirect_to signin_path, :notice => "Password has been reset!"
	  else
	    render :edit
	  end
	end
end
