class ActivitiesController < ApplicationController
	def index
    	@activities = Activity.order("created_at desc")
    	@comment = Comment.find_by_id(params[:id])
    	
  	end
end
