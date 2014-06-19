class ResponsesController < ApplicationController
  before_filter :signed_in_user
  #load_and_authorize_resource

  def destroy
  	Response.find(params[:id]).destroy
    flash[:success] = "Assignment withdrawn from selected student."
    redirect_back_or past_due_assignments_user_path(current_user)
  end
end
