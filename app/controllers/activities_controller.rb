class ActivitiesController < ApplicationController
	def index
    	@activities = Activity.paginate(page: params[:page], per_page: 30, 
    		order: 'created_at DESC')
  	end

  	def recipient
  		User.find(activity.recipient_id)
  	end
end
