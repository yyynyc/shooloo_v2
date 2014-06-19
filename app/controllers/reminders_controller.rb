class RemindersController < ApplicationController
	before_filter :signed_in_user
  #load_and_authorize_resource
  respond_to :html, :js

	def create
		@response = Response.find(params[:reminder][:reminded_response_id])
		current_user.reminders.create!(reminded_response_id: @response.id, remindee_id: @response.assignee_id)
    respond_to do |format|
    	format.html {redirect_to root_url }
        format.js
    end
	end
end