class PostsController < ApplicationController
	before_filter :signed_in_user
  before_filter :correct_user,   only: :destroy
  load_and_authorize_resource
  
  def index
    @search = Post.visible.search(params[:q])
    @posts = @search.result.visible.paginate(page: params[:page], per_page: 30, order: 'updated_at DESC')
    @search.build_condition
    @like = current_user.likes.build(params[:like])
  end

  def show
    index
    render :action => 'index'
  end

  def create
  	@post = current_user.posts.build(params[:post])
    if @post.save
      flash[:success] = "Fantastic! Thank you for your post. 
        Now try to gather some fans for your posts."
      redirect_to root_path
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def edit
    @post = current_user.posts.find_by_id(params[:id])
  end

  def update
    @post = current_user.posts.find_by_id(params[:id])
    if     
      @post.update_attributes(params[:post])
      flash[:success] = "You have upddated your post successfully!"
      redirect_to new_post_comment_path(@post)
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
     flash[:success] = "Sorry, you've just lost some points."
    redirect_to root_url
  end

  def correct_user
      @post = current_user.posts.find_by_id(params[:id])
      redirect_to root_url if @post.nil?
  end
end
