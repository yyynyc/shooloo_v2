class IntroductionsController < ApplicationController
	before_filter :signed_in_user
  before_filter :correct_user, only: :new
  def new
    @introduction = Introduction.new
  end

  def create
    @introduction = Introduction.create(params[:introduction])
    if @introduction.save
      if current_user.role == "teacher"
        flash[:success] = "Success! You've just earned 30 points towards winning an #{ActionController::Base.helpers.link_to "Advocacy Award", root_path}! Complete the profile below or #{ActionController::Base.helpers.link_to "skip", new_user_import_path} for now.".html_safe
      else
        flash[:success] = "Success! You've just earned 30 points towards winning an #{ActionController::Base.helpers.link_to "Advocacy Award", root_path}! Complete the profile below to participate in our competition.".html_safe
      end 
      redirect_to edit_user_path(current_user)
    else
      flash.now[:error] = "Sorry, we can't find that email in our member database. Please try again or #{ActionController::Base.helpers.link_to "skip for now", edit_user_path(current_user)}.".html_safe
      render 'new'
    end
  end

  def correct_user
      @authorizations = current_user.authorizations
      redirect_to root_url if !@authorizations.blank?
  end
end