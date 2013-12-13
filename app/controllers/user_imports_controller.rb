class UserImportsController < ApplicationController
  before_filter :signed_in_user
  load_and_authorize_resource except: :new

  def new
    @user_import = UserImport.new
  end

  def create
    @user_import = UserImport.new(params[:user_import])
    if @user_import.save(current_user.id)
      redirect_to authorizations_path, notice: "Imported students successfully."
    else
      render :new
    end
  end
end
