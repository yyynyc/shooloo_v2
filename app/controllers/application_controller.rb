class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  rescue_from CanCan::AccessDenied do |exception|
  	flash[:error] = "Sorry, but you don't have the ability to do this now. Get referrals or authorization first."
  	redirect_to my_abilities_path
  end

  def track_activity(trackable, action = params[:action])
  	current_user.activities.create! action: action, trackable: trackable 
  end
end
