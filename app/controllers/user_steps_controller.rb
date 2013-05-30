class UserStepsController < ApplicationController
	include Wicked::Wizard
	steps :names, :roles, :avatar
	before_filter :signed_in_user

	def show
		@user = current_user #||= User.find(session[:user_id])
		render_wizard
	end

	def update
		@user = current_user
		@user.attributes = params[:user]
		render_wizard @user
	end
end
