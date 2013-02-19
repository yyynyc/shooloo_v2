class PostsController < ApplicationController
	before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user,   only: :destroy
  
  def index
    @search = Post.search(params[:q])
    @posts = @search.result.paginate(page: params[:page], per_page: 30)
    @search.build_condition
  end

  def create
  	@post = current_user.posts.build(params[:post])
    #if params[:preview_button]
      #render partial:'posts/preview'        
    #else
      if @post.save
        flash[:success] = "Good job! You have created a math problem."
        redirect_to root_url
      else
        @feed_items = []
        render 'static_pages/home'
      end
    #end
  end

  def edit
    @post = current_user.posts.find_by_id(params[:id])
  end

  def update
    @post = current_user.posts.find_by_id(params[:id])
    #if params[:preview_button] || !@post.update_attributes(params[:post])
      #render 'edit'
    #else 
    if     
      @post.update_attributes(params[:post])
      flash[:success] = "You have upddated your post successfully!"
      redirect_to root_url
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    redirect_to root_url
  end

  def correct_user
      @post = current_user.posts.find_by_id(params[:id])
      redirect_to root_url if @post.nil?
  end
end