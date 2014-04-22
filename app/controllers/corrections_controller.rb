class CorrectionsController < ApplicationController
	def new
        @post = Post.find(params[:post_id])
		@correction = Correction.new
        @correction.corrected_post = @post         
        if @post.state == "submitted"
            @post.checkout!
        end
	end

	def create
        if params.has_key?(:post_id)
		  @post = Post.find(params[:post_id])
        end
        @correction = current_user.corrections.build(params[:correction])
        if @correction.save
            flash[:success]="Correction saved and published!"
            redirect_to root_path
        else
            render 'new'
        end
	end

	def edit
		if current_user.admin?
            @correction = Correction.find_by_id(params[:id])
        else
            @correction = current_user.corrections.find_by_id(params[:id])
        end
        @correction.corrected_post = @post 
	end

	def update
		if current_user.admin?
            @correction = Correction.find_by_id(params[:id])
        else
            @correction = current_user.corrections.find_by_id(params[:id])
        end
        if @correction.update_attributes(params[:correction])
          flash[:success] = "You have updated your correction successfully!"
          redirect_to post_comments_path(@correction.corrected_post)          
        else
          render 'edit'
        end
	end

	def show
	end

	def index
	end
end
