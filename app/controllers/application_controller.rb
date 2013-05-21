class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  rescue_from CanCan::AccessDenied do |exception|
  	flash[:error] = "You don't have pemission to do this. Get referrals or authorization first."
  	redirect_to root_url
  end

  def track_activity(trackable, action = params[:action])
  	current_user.activities.create! action: action, trackable: trackable 
  end
end
