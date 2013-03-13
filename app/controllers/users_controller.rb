class UsersController < ApplicationController
  before_filter :signed_in_user
  skip_before_filter :signed_in_user, only: [:new, :create]
  #except: 
    #[:index, :show, :edit, :update, :destroy, :following, :followers, :rated_posts]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user, only: :destroy

  def new
  	@user = User.new
  end

  def index
    @search = User.search(params[:q])
    @users = @search.result.paginate(page: params[:page], per_page: 30, order: 'screen_name ASC')
    @search.build_condition
  end

  def show
  	@user = User.find(params[:id])
    @posts = @user.posts.paginate(page: params[:page], order: "updated_at DESC")
    @post = @user.posts.build(params[:post])
    @rating=current_user.ratings.build(params[:rating])
  end

  def create
  	@user = User.new(params[:user])
  	if @user.save
  		sign_in @user
  		flash[:success] = "Welcome to Shooloo Games!"
  		redirect_to @user
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
      redirect_to @user
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

  def rated_posts
    @title = "Rated Posts"
    @user = User.find(params[:id])
    @rated_posts = @user.rated_posts.paginate(page: params[:page])
    @rating=current_user.ratings.build(params[:rating])
    @post  = current_user.posts.build
    render 'show_rated_posts'
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
