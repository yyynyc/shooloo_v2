class ResponsesController < ApplicationController
  before_filter :signed_in_user
  load_and_authorize_resource

  def index
  end

  def destroy
  	Response.find(params[:id]).destroy
    flash[:success] = "Assignment withdrawn from selected student."
    redirect_to assignments_user_path(current_user)
  end
end
