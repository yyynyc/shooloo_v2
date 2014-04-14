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

  # unless Rails.application.config.consider_all_requests_local
  #   rescue_from Exception, with: lambda { |exception| render_error 500, exception }
  #   rescue_from ActionController::RoutingError, ActionController::UnknownController, ::AbstractController::ActionNotFound, ActiveRecord::RecordNotFound, with: lambda { |exception| render_error 404, exception }
  # end
 
  # private
  
  # def render_error(status, exception)
  #   respond_to do |format|
  #     format.html { render template: "errors/#{status}", layout: 'layouts/application', status: status }
  #     format.all { render nothing: true, status: status }
  #   end
  # end
end
