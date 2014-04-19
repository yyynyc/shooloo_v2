class UserImportsController < ApplicationController
  before_filter :signed_in_user
  load_and_authorize_resource except: :new

  def new
    @user_import = UserImport.new
  end

  def create
    @user_import = UserImport.new(params[:user_import])
    if @user_import.save(current_user.id)      
      @point = Point.find_by_user_id(current_user.id)
      @point.advocacy += ShoolooV2::USER_IMPORT
      @point.save!
      flash[:success] = "Import success! You've just earned 30 points toward #{ActionController::Base.helpers.link_to "winning", root_path} an Advocacy Award!".html_safe
      if !current_user.introducer.blank?
        @introducer_point = Point.find_by_user_id(current_user.introducer.id)
        @introducer_point.advocacy += ShoolooV2::USER_IMPORT
        @introducer_point.save!
        Activity.create!(action: "import", trackable: current_user.introduction, 
          user_id: current_user.id, recipient_id: current_user.introducer.id)
      end 
      redirect_to authorizations_path
    else
      render :new
    end
  end
end
