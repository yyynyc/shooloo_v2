class CorrectionsController < ApplicationController
  before_filter :signed_in_user
  before_filter :editor, only: [:new, :create]
  before_filter :correct_editor, only: [:edit, :update]
  before_filter :correct_user, only: :show
  before_filter :admin_user, only: [:index, :editors, :destroy]

	def new
    @post = Post.find(params[:post_id])
		@correction = Correction.new(level_id: @post.level_id, 
      domain_id: @post.domain_id, standard_id: @post.standard_id)
    @alarm = Alarm.new      
    if @post.state.in?(["submitted", "old"])
        @post.checkout!
    end
	end

	def create
    if params.has_key?(:post_id)
	    @post = Post.find(params[:post_id])
    end
    @correction = current_user.corrections.build(params[:correction])
    if @correction.save
      @post = @correction.corrected_post
      render 'show'
    else
      @post = @correction.corrected_post
      @alarm = Alarm.new 
      render 'new'
    end
	end

  def draft
    @correction = current_user.corrections.find([:correction_id])
    @post = @correction.corrected_post
  end

	def edit
    @correction = Correction.find(params[:id])
    @post = @correction.corrected_post
    @alarm = Alarm.new 
	end

	def update
		if current_user.admin?
      @correction = Correction.find_by_id(params[:id])
    else
      @correction = current_user.corrections.find_by_id(params[:id])
    end
    @correction.update_attributes(params[:correction])
    if params[:button] == "save"
      @correction.save
      @post = @correction.corrected_post     
      render 'show'
    elsif params[:button] == "submit"
      if @correction.submit
        @post = @correction.corrected_post 
        flash[:success]="Correction saved and published!"
        redirect_to root_path         
      else
        @post = @correction.corrected_post
        @alarm = Alarm.new 
        render 'edit'
      end
    elsif params[:button] == "revision"
      if @correction.revise
        @post = @correction.corrected_post 
        @post.update_attributes!(steps: @correction.steps, level_id: @correction.level_id, 
          domain_id: @correction.domain_id, standard_id: @correction.standard_id,
          hstandard_id: @correction.hstandard_id)
        flash[:success]="Revised!"
        redirect_to correction_path(@correction)         
      else
        @post = @correction.corrected_post
        @alarm = Alarm.new 
        render 'edit'
      end
    end
	end

	def show
    @correction = Correction.find(params[:id])
    @post = @correction.corrected_post       
  end

	def index
    @corrections_revised = Correction.where(state: "revised").order('updated_at DESC')
    @corrections_published = Correction.where(state: "submitted").order('updated_at DESC')
    @corrections_draft = Correction.where(state: "draft").order('created_at DESC')
    @checked_out = Post.where(state: "under_review").order('created_at DESC')
	end

  def all_editors
    @editors = User.where(role: "editor").order('first_name ASC')
  end

  def editor
    @correction = Correction.new
    unless current_user.role=="editor" || current_user.admin? 
        flash[:error] = "Sorry, you can't correct that post."
        redirect_to root_url 
    end
  end

  def correct_editor
    @correction = Correction.find(params[:id])
    unless current_user == @correction.editor || current_user.admin? 
        flash[:error] = "Sorry, you can't edit that correction."
        redirect_to root_url 
    end
  end

  def correct_user
    @correction = Correction.find(params[:id])
    if current_user?(@correction.corrected_post.user) || current_user==@correction.editor ||
      current_user.admin? || current_user.in?(@correction.corrected_post.user.authorizers)
        return true
    else
        flash[:error] = "Sorry, you don't have access to that correction."
        redirect_to root_url 
    end
  end

  def admin_user
    unless current_user.admin?
      flash[:error] = "Sorry, you don't have access to that correction."
      redirect_to root_url 
    end
  end
end
