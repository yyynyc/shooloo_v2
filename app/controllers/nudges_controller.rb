class NudgesController < ApplicationController
  before_filter :signed_in_user
  #load_and_authorize_resource

  respond_to :html, :js

  def create
    @user = User.find(params[:nudge][:nudged_id])
    current_user.nudge!(@user)
    respond_with @user
  end

  def destroy
    @user = Nudge.find(params[:id]).nudged
    current_user.disnudge!(@user)
    respond_with @user
  end
end