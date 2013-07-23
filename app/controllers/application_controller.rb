class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  rescue_from CanCan::AccessDenied do |exception|
  	flash[:error] = "Sorry, you need to #{ActionController::Base.helpers.link_to "get authorization", new_authorization_path} or #{ActionController::Base.helpers.link_to "get referral", new_referral_path} first to gain access to this functionality.".html_safe
  	redirect_to my_abilities_path
  end

  def track_activity(trackable, action = params[:action])
  	current_user.activities.create! action: action, trackable: trackable 
  end
end
