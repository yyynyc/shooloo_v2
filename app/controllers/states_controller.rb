class StatesController < ApplicationController
	def create
		@user = current_user
		@state = State.create!(user_id: @user.id, complete: true)
		if @user.role?("student") && !@user.parent_email.nil?
        	UserMailer.parental_consent(@user).deliver
      	end
      	flash[:success] = "Bravo! You've just earned some points! 
        		You are one step closer toward getting a gift."
        redirect_to my_abilities_path
	end
end