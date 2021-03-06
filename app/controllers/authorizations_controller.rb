class AuthorizationsController < ApplicationController
  before_filter :signed_in_user
  respond_to :html, :js

  def new
    @teachers = User.where('users.role' => ['teacher', 'parent', 'tutor', 'other'])
  	@authorizer = @teachers.search(params[:q])
    @authorizers = @authorizer.result
    @authorization = Authorization.new
    set_meta_tags title: 'Request Authorization', 
        description: 'Shooloo member requests authorization to publish posts and comments', 
        noindex: true,
        nofollow: true
  end

  def create
    @user = User.find(params[:authorization][:authorizer_id])
    @authorization = current_user.authorizations.build(params[:authorization])
    if @authorization.save
      if @authorization.approval=="accepted"
        if current_user.role=="teacher"
          flash[:success] = "Success! Import your student roster and get 30 points toward getting an Advocate Teacher Prize!"
          redirect_to new_user_import_path
        else
          flash[:success] = "Success!"
          redirect_to root_path
        end
      else
        flash[:success] = "Thank you! An email will be sent to you regarding your request status. Meanwhile, check out #{ActionController::Base.helpers.link_to "other members", users_path} and #{ActionController::Base.helpers.link_to "posts", posts_path}.".html_safe 
        redirect_to videos_path
      end
    else
      flash.now[:error] = "Sorry, authorization code is incorrect. Leave it blank, and press the blue button again."
      render 'new'
    end
  end

  def destroy
    @user = Authorization.find(params[:id]).authorizer
    current_user.auth_withdraw!(@user)
    respond_with @user
    sign_in current_user 
  end

  def index
    @search_student = current_user.authorized_users.order('grade ASC', 'last_name ASC').search(params[:q])
    @auth_seekers = @search_student.result 
    @search_student.build_condition
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

  def show
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

  def teacher_delete_auth
    @authorization = Authorization.find(params[:id])
    @authorization.destroy
    flash[:success] = "#{@authorization.authorized.first_name} #{@authorization.authorized.last_name} has been deleted off your student roster."
    redirect_to authorizations_path
  end
end
