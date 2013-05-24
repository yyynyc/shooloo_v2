class LikesController < ApplicationController
  before_filter :signed_in_user
  load_and_authorize_resource

  def new
    @like = Like.post
    @post  = Post.find(params[:post_id])    
    @comment = Comment.find(params[:comment_id])
  end

  def create
    if params.has_key?(:post_id)
      @post = Post.find(params[:post_id])
      @like = current_user.likes.create!(params[:like])
      respond_to do |format|
        format.html {redirect_to root_url }
        format.js
      end
      @like.liked_post = @post
    elsif params.has_key?(:comment_id)
      @comment = Comment.find(params[:comment_id])   
      @like = current_user.likes.create!(params[:like])
      respond_to do |format|
        format.html {redirect_to root_url }
        format.js do
          render action: 'create_like_comment'
        end
      end
      @like.liked_comment = @comment
      @comment.commented_post = @commented_post
    end
  end

  def destroy
    @like = Like.find(params[:id])
    @post = Like.find(params[:id]).liked_post 
    @comment = Like.find(params[:id]).liked_comment 
    @like.destroy
    respond_to do |format|
      format.html {redirect_to root_url}
      format.js do
        unless @post
          render action: 'destroy_like_comment' 
        end
      end
    end 
  end
end