class LikesController < ApplicationController
  before_filter :signed_in_user

  def new
    @alarm = Like.new
    @post  = Post.find_by_id(params[:post_id])    
    @comment = Comment.find_by_id(params[:comment_id])
  end

  def create
    @post  = Post.find(params[:post_id])
    @comment = Comment.find_by_id(params[:comment_id])
    @like = current_user.likes.build(params[:like])
    
    if @comment
      @like.comment = @comment
      if @like.save
        respond_to do |format|
          format.html {redirect_to @comment }
          format.js
        end
      end
    else
      @like.post = @post
      if @like.save
        respond_to do |format|
          format.html {redirect_to @post}
          format.js
        end
      end
    end    
  end

  def destroy
    @like = Like.find(params[:id])
    if @like.post_id.nil?
      @comment = Like.find(params[:id]).comment 
      @like.destroy
      respond_to do |format|
        format.html {redirect_to @comment}
        format.js
      end 
    else
      @post = Like.find(params[:id]).post 
      @like.destroy
      respond_to do |format|
        format.html {redirect_to @post}
        format.js  
      end 
    end
  end
end