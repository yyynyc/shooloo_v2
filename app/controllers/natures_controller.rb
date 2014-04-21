class NaturesController < ApplicationController
	def create
		@user = current_user
		@nature = Nature.create!(user_id: @user.id, complete: true)
		if @user.role?("student") && !@user.parent_email.blank?
        	UserMailer.parental_consent(@user).deliver
      	end
      	flash[:success] = "Bravo! You can now #{ActionController::Base.helpers.link_to "get authorization", new_authorization_path} or #{ActionController::Base.helpers.link_to "get referral", new_referral_path}. You are one step closer toward #{ActionController::Base.helpers.link_to "getting a gift", gift_receiving_path} from Shooloo.".html_safe
        redirect_to my_abilities_path
	end
end