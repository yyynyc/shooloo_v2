require 'will_paginate/array'

class UsersController < ApplicationController
  before_filter :signed_in_user
  skip_before_filter :signed_in_user, only: [:new, :create]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: [:destroy]

  def new
  	@user = User.new
    @authorization = @user.authorizations.build
  end

  def index
    @search = User.search(params[:q])
    @users = @search.result.paginate(page: params[:page], 
      per_page: 30, order: 'screen_name ASC')
    @search.build_condition
  end

  def show
    index
    render :action =>'index'
    #@user = User.find(params[:id])
    #@posts = @user.posts.visible.paginate(page: params[:page], order: "updated_at DESC")
    #@post = @user.posts.build(params[:post])
    #@rating=current_user.ratings.build(params[:rating])
    #@alarm = current_user.alarms.build
    #@comments = @user.comments.paginate(page: params[:page], order: "created_at DESC")
    #@comment = current_user.comments.build(params[:comment])
  end

  def create
  	@user = User.new(params[:user])
  	if @user.save
  		sign_in @user
  		flash[:success] = "Welcome to Shooloo Learning!"
  		redirect_to root_path
  	else
  		render 'new'
  	end
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Information updated successfully!"
      sign_in @user
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  def posts
    @user = User.find(params[:id])
    @posts = @user.posts.visible.paginate(page: params[:page], order: "updated_at DESC")
    @post = @user.posts.build(params[:post])
    @rating=current_user.ratings.build(params[:rating])
    @alarm = current_user.alarms.build(params[:alarm])
    @like = current_user.likes.build(params[:like])
  end


  def rated_posts
    @title = "Rated Posts"
    @user = User.find(params[:id])
    @rated_posts = @user.rated_posts.visible.paginate(page: params[:page])
    @rating=current_user.ratings.build(params[:rating])
    @post  = current_user.posts.build
    @alarm = current_user.alarms.build
    @like = current_user.likes.build
    render 'show_rated_posts'
  end

  def commented_posts
    @title = "Commented Posts"
    @user = User.find(params[:id])
    @commented_posts = @user.comments(order: "created_at DESC").collect(&:commented_post).keep_if{ |x| x.visible == true }.uniq.paginate(page: params[:page], per_page: 30)
    @comment=current_user.comments.build(params[:comment])
    @post  = current_user.posts.build
    @alarm = current_user.alarms.build
    @like = current_user.likes.build
    render 'show_commented_posts'
  end

  def alarmed_posts
    @title = "Hidden Posts"
    @user = User.find(params[:id])
    @alarmed_posts = @user.posts.hidden.paginate(page: params[:page], order: "updated_at DESC")
    @alarm=current_user.alarms.build(params[:alarm])
    @post  = current_user.posts.build
    @like = current_user.likes.build
    render 'show_alarmed_posts'
  end

  def show_activity
    @my_activities = Activity.where(recipient_id: current_user.id).paginate(page: params[:page], 
      per_page: 40, order: 'created_at DESC')
  end
  

  private
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
