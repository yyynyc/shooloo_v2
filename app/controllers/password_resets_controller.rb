class PasswordResetsController < ApplicationController
	def new 
		set_meta_tags title: 'Request Password Reset', 
    		description: 'Shooloo member requests to reset password', 
    		keywords: %w[Shooloo password reset],
    		noindex: true,
    		nofollow: true
	end

  	def create
	  user = User.find_by_screen_name(params[:screen_name])
	  if !user.nil?
	  	if !user.personal_email.nil?
	  		user.send_password_reset if user
	  		redirect_to root_url, :notice => "Password reset instruction has been sent to your personal email address on file."
	  	else
	  		flash[:error] = "You don't have a personal email address on file. Ask your teacher to reset your password."
	  		render 'new'
	  	end
	  else
	  	flash[:error] = "Invalid screen name. Please contact admin to reset your password."
	  	redirect_to contact_path
	  end
	end

	def edit
	  @user = User.find_by_password_reset_token!(params[:id])
	  set_meta_tags title: 'Password Reset', 
    		description: 'Shooloo member resets password', 
    		keywords: %w[Shooloo password reset],
    		noindex: true,
    		nofollow: true
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
