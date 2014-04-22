class CorrectionsController < ApplicationController
	def new
		@correction = Correction.new
        @post = Post.find(params[:post_id])
        # @post.checkout!
	end

	def create
		@post = Post.find(params[:post_id])
        @correction = current_user.corrections.build(params[:correction])
        @correction.corrected_post = @post 
	end

	def edit
		if current_user.admin?
            @correction = Correction.find_by_id(params[:id])
        else
            @correction = current_user.corrections.find_by_id(params[:id])
        end
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
