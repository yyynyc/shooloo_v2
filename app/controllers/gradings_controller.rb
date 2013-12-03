class GradingsController < ApplicationController
  before_filter :signed_in_user
  load_and_authorize_resource

  def new
  	@post = Post.find(params[:post_id])
  	@grading = Grading.new(level_id: @post.level_id, 
        domain_id: @post.domain_id, standard_id: @post.standard_id,
        grader_id: current_user.id, post_id: @post.id)
  end

  def create
  	@post = Post.find(params[:post_id])
  	@grading = @post.gradings.build(params[:grading])
  	if @grading.save
  		flash[:success] = "Thank you for grading this post!"
  		redirect_to root_path
  	else
  		render 'new'
  	end
  end
end