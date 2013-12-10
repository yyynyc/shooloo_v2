class GradingsController < ApplicationController
  before_filter :signed_in_user
  load_and_authorize_resource

  def new
    if params.has_key?(:post_id)
    	@post = Post.find(params[:post_id])
      @grading = Grading.new(level_id: @post.level_id, 
        domain_id: @post.domain_id, standard_id: @post.standard_id,
        grader_id: current_user.id, graded_post_id: @post.id)
    else
      @comment = Comment.find(params[:comment_id])
      @post = @comment.commented_post
      @grading = Grading.new(level_id: @post.level_id, 
        domain_id: @post.domain_id, standard_id: @post.standard_id,
        grader_id: current_user.id, graded_comment_id: @comment.id)
    end
  end

  def create
    @grading = current_user.gradings.build(params[:grading])
    if @grading.save
      if !@grading.graded_post.nil?
        @post  = @grading.graded_post         
  		  flash[:success] = "Thank you for grading this post!"
      elsif !@grading.graded_comment.nil?
        @comment = @grading.graded_comment
        @post = @comment.commented_post
      end
		  redirect_to post_comments_path(@post)
    else
      if !@grading.graded_post.nil?
        @post  = @grading.graded_post
      elsif !@grading.graded_comment.nil?
        @comment = @grading.graded_commented
      end
      render 'new'
    end
  end

  def edit
    @grading = current_user.gradings.find_by_id(params[:id])
    if !@grading.graded_post_id.nil?
      @post = @grading.graded_post
    else
      @comment = @grading.graded_comment
      @post = @comment.commented_post
    end
  end

  def update
    if @grading.update_attributes(params[:grading])
      flash[:success] = "You have upddated your grading results successfully!"
      if !@grading.graded_post.nil?
        @post = @grading.graded_post        
      else 
        @comment = @grading.graded_comment
        @post = @comment.commented_post
      end
      redirect_to post_comments_path(@post)
    else
      if !@grading.graded_post.nil?
        @post = @grading.graded_post        
      else 
        @comment = @grading.graded_comment
        @post = @comment.commented_post
      end
      render 'edit'
    end
  end

  def show
    @grading = Grading.find(params[:id])
    if !@grading.graded_post_id.nil?
      @post = @grading.graded_post
    else
      @comment = @grading.graded_comment
      @post = @comment.commented_post
    end
  end
end