class LikesController < ApplicationController
  before_filter :signed_in_user
  #load_and_authorize_resource

  def new
    @like = Like.new
    @post  = Post.find(params[:post_id])    
    @comment = Comment.find(params[:comment_id])
    @lesson  = Lesson.find(params[:lesson_id])
  end

  def create
    if params.has_key?(:post_id)
      @post = Post.find(params[:post_id])
      if @post.likes_count.nil?
        @post.likes_count = 0
      end
      @like = current_user.likes.create!(params[:like])
      @post.likes_count += 1
      @post.save(validate: false)
      respond_to do |format|
        format.html {redirect_to root_url }
        format.js
      end
      @like.liked_post = @post
    elsif params.has_key?(:comment_id)
      @comment = Comment.find(params[:comment_id])
      if @comment.likes_count.nil?
        @comment.likes_count = 0
      end   
      @like = current_user.likes.create!(params[:like])
      @comment.likes_count += 1
      @comment.save(validate: false)
      respond_to do |format|
        format.html {redirect_to root_url }
        format.js do
          render action: 'create_like_comment'
        end
      end
      @like.liked_comment = @comment
      @comment.commented_post = @commented_post
    elsif params.has_key?(:lesson_id)
      @lesson = Lesson.find(params[:lesson_id])
      if @lesson.likes_count.nil?
        @lesson.likes_count = 0
      end   
      @like = current_user.likes.create!(params[:like])
      @lesson.likes_count += 1
      @lesson.save(validate: false)
      respond_to do |format|
        format.html {redirect_to lessons_user_path(current_user) }
        format.js do
          render action: 'create_like_lesson'
        end
      end
    end
  end

  def destroy
    @like = Like.find(params[:id])
    @post = Like.find(params[:id]).liked_post 
    @comment = Like.find(params[:id]).liked_comment 
    @lesson = Like.find(params[:id]).liked_lesson
    @like.destroy
    if @post
      @post.likes_count -= 1
      @post.save(validate: false)
      respond_to do |format|
        format.html {redirect_to root_url}
        format.js 
      end
    elsif @comment
      @comment.likes_count -= 1
      @comment.save(validate: false)
      respond_to do |format|
        format.html {redirect_to root_url}
        format.js do
            render action: 'destroy_like_comment' 
        end
      end
    elsif @lesson
      @lesson.likes_count -= 1
      @lesson.save(validate: false)
      respond_to do |format|
        format.html {redirect_to lessons_user_path(current_user)}
        format.js do
            render action: 'destroy_like_lesson' 
        end
      end
    end
  end
end