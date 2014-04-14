class UserImportsController < ApplicationController
  before_filter :signed_in_user
  load_and_authorize_resource except: :new

  def new
    @user_import = UserImport.new
  end

  def create
    @user_import = UserImport.new(params[:user_import])
    if @user_import.save(current_user.id)
      if current_user.authorized_users.blank?
        @point = Point.find_by_user_id(current_user.id)
        @point.advocacy += ShoolooV2::USER_IMPORT
        @point.save!
        @introducer_id = Introduction.find_by_introducee_id(current_user.id).introducer_id
        @introducer_point = Point.find_by_user_id(@introducer_id)
        @introducer_point.advocacy += ShoolooV2::USER_IMPORT
        @introducer_point.save!
      end
      Flash[:success] = "Import success! You've just earned 30 points toward #{ActionController::Base.helpers.link_to "winning", root_path} an Advocacy Award!".html_safe
      redirect_to authorizations_path
    else
      render :new
    end
  end
end
