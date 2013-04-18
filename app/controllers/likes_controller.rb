class LikesController < ApplicationController
  before_filter :signed_in_user

  def new
    @like = Like.new
    @post  = Post.find_by_id(params[:post_id])    
    @comment = Comment.find_by_id(params[:comment_id])
  end

  def create
    @post = Post.find(params[:post_id])
    @like = current_user.likes.build(params[:like])
    @like.save
    respond_to do |format|
      format.html {redirect_to root_url }
      format.js
    end
    @like.liked_post = @post   
  end

  def destroy
    @like = Like.find(params[:id])
    @post = Like.find(params[:id]).liked_post 
    @like.destroy
    respond_to do |format|
      format.html {redirect_to root_url}
      format.js  
    end 
  end
end