class SessionsController < ApplicationController
	def new
    set_meta_tags title: 'Sign In', 
        description: 'Sign in Shooloo to access over 1,000 student-authored math word problems aligned with the Common Core State Standard.', 
        keywords: 'Shooloo, sign in, math, word problem, Common Core'
	end

	def create
		user = User.find_by_screen_name(params[:session][:screen_name])
    	if user && user.authenticate(params[:session][:password])
      		sign_in user      		
      		redirect_back_or my_alerts_path
          unless Event.where(benefactor_id: user.id, event: "sign in").where(
              'Date(created_at)=?', Date.today).any? || user.id == 1
      		  Event.create!(benefactor_id: user.id, beneficiary_id: 1, 
        		  event: "sign in", value: ShoolooV2::SIGN_IN)
            flash[:message] = "Welcome back! You've just earned some points towards getting a gift. To get more points, #{ActionController::Base.helpers.link_to "publish a post", root_path} or #{ActionController::Base.helpers.link_to "comment on other people's post", posts_path}.". html_safe
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
