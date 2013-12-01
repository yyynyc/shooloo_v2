class AssignmentsController < ApplicationController
  before_filter :signed_in_user
  load_and_authorize_resource

  def index
    @assignments = Assignment.order("created_at DESC")
  end

  def new
    if params.has_key?(:post_id)
      @post  = Post.find(params[:post_id])
      @assignment = Assignment.new(level_id: @post.level_id, 
        domain_id: @post.domain_id, standard_id: @post.standard_id,
        assigner_id: current_user.id, assigned_post_id: @post.id)
    else
      @assignment = Assignment.new
      
    end
    @assignees = current_user.authorized_users.order('grade ASC, last_name ASC')
  end

  def create
    @assignment=current_user.assignments.build(params[:assignment])
    if @assignment.save
    	flash[:success] = "Successfully created assignment!"
    	redirect_to user_assignments_path(current_user)
    else
      @post = @assignment.assigned_post
    	render 'new'
    end
  end

  def show
    @assignment = Assignment.find(params[:id])
    @responses = @assignment.responses
  end
end
