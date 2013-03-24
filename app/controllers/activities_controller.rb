class ActivitiesController < ApplicationController
	def index
    	@activities = Activity.paginate(page: params[:page], per_page: 30, order: 'created_at DESC')
    	@my_activities = Activity.where(recipient_id: current_user.id).paginate(page: params[:page], per_page: 30, order: 'created_at DESC')
  	end
end
