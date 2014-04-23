class CorrectionsController < ApplicationController
	def new
    @post = Post.find(params[:post_id])
		@correction = Correction.new 
    @alarm = Alarm.new      
    if @post.state == "submitted"
        @post.checkout!
    end
	end

	def create
    if params.has_key?(:post_id)
	    @post = Post.find(params[:post_id])
    end
    @correction = current_user.corrections.build(params[:correction])
    @correction.save
    @post = @correction.corrected_post
    render 'show'
    # render 'draft'
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
    end
	end

	def show
    @correction = Correction.find(params[:id])
    @post = @correction.corrected_post       
  end

	def index
	end
end
