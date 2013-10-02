class AuthorizationsController < ApplicationController
  before_filter :signed_in_user
  respond_to :html, :js

  def new
    @teachers = User.where( 
      'users.role' => 'teacher')
  	@authorizer = @teachers.search(params[:q])
    @authorizers = @authorizer.result
    set_meta_tags title: 'Request Authorization', 
        description: 'Shooloo member requests authorization to publish posts and comments', 
        noindex: true,
        nofollow: true
  end

  def create
    @user = User.find(params[:authorization][:authorizer_id])
    current_user.auth_request!(@user)
    flash[:notice] = "Thank you! An email will be sent to you regarding your request status. Meanwhile, check out #{ActionController::Base.helpers.link_to "other members", users_path} and #{ActionController::Base.helpers.link_to "posts", posts_path}.".html_safe 
    respond_with @user
  end

  def destroy
    @user = Authorization.find(params[:id]).authorizer
    current_user.auth_withdraw!(@user)
    respond_with @user
  end

  def index
    @auth_seekers = current_user.authorized_users.order('grade ASC, last_name ASC') 
    set_meta_tags title: 'Grant Authorization', 
        description: 'Shooloo teacher grants authorization to publish posts and comments', 
        noindex: true,
        nofollow: true  
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

  def reset_student_password
    @user = User.find(params[:id])
    @user.update_attributes(params[:user])
    current_user.reset_password!(@user)
    respond_with @user
  end

  def teacher_delete_authorization
    current_user.auth_withdraw!
    flash[:success] = "User has been deleted off your student roster."
    redirect_to authorizations_path
  end
end
