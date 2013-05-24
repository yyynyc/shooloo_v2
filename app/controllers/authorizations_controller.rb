class AuthorizationsController < ApplicationController
  before_filter :signed_in_user
  respond_to :html, :js

  def new
    @teachers = User.where( 
      'users.role' => 'teacher')
  	@authorizer = @teachers.search(params[:q])
    @authorizers = @authorizer.result
  end

  def create
    @user = User.find(params[:authorization][:authorizer_id])
    current_user.auth_request!(@user)
    respond_with @user
  end

  def destroy
    @user = Authorization.find(params[:id]).authorizer
    current_user.auth_withdraw!(@user)
    respond_with @user
  end

  def index
    @auth_seekers = current_user.authorized_users.all
#    @user = @auth_seekers.find(params[:id])
#    @user = User.find(params[:authorization][:authorized_id])
    
  end

  def update
    @authorization = Authorization.find(params[:id])
    @user = @authorization.authorized
    current_user.auth_grant!(@user)
    respond_with @user    
  end

  def decline
    @authorization = Authorization.find(params[:id])
    @user = @authorization.authorized
    current_user.auth_decline!(@user)
    respond_with @user    
  end
end
