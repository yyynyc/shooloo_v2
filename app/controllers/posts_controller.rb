class PostsController < ApplicationController
	before_filter :signed_in_user, only: [:create, :destroy]
  
  def index
  end

  def create
  	 @post = current_user.posts.build(params[:post])
    if @post.save
      flash[:success] = "Good job! You have created a math problem."
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
  end
end