class ActivitiesController < ApplicationController
	before_filter :signed_in_user
	
	def index
    	@activities = Activity.joins(:user).where(users: {admin: false}).paginate(
    		page: params[:page], per_page: 30, order: 'created_at DESC')
  	end

  	def update
  		@activity = Activity.find(params[:id])
  		unless @activity.read?
	  		current_user.read!(@activity)
	  		respond_to do |format|
	  			format.html {redirect_to @my_activities}
	  			format.js
	  		end
	  	else
		  	current_user.unread!(@activity)
	  		respond_to do |format|
	  			format.html {redirect_to @my_activities}
	  			format.js
	  		end	
	  	end
  	end
end
