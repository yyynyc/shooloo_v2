class IntroductionsController < ApplicationController
	before_filter :signed_in_user

  def new
    @introduction = Introduction.new
  end

  def create
    @introduction = current_user.introductions.build(params[:introduction])
    if @introduction.save
      flash[:success] = "Success! Complete your profile below to participate in our math competition or #{ActionController::Base.helpers.link_to "skip for now", root_path}.".html_safe 
      redirect_to edit_user_path(current_user)
    else
      flash.now[:error] = "Sorry, we can't find that email in our member database. Please try again or #{ActionController::Base.helpers.link_to "skip for now", edit_user_path(current_user)}.".html_safe
      render 'new'
    end
  end
end