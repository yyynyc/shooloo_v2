class PostsController < ApplicationController
	before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user,   only: :destroy
  
  def index
  end

  def create
  	@post = current_user.posts.build(params[:post])
    #if params[:preview_button]
      #render 'posts/preview'        
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
    if @post.update_attributes(params[:post])
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