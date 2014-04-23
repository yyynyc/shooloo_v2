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
        if @correction.save
            @post = @correction.corrected_post 
            @post.verify!
            flash[:success]="Correction saved and published!"
            redirect_to root_path
        else
            @post = @correction.corrected_post 
            @alarm = Alarm.new
            render 'new'
        end
	end

	def edit
		if current_user.admin?
            @correction = Correction.find_by_id(params[:id])
        else
            @correction = current_user.corrections.find_by_id(params[:id])
        end
        @post = @correction.corrected_post
        @alarm = Alarm.new 
	end

	def update
		if current_user.admin?
            @correction = Correction.find_by_id(params[:id])
        else
            @correction = current_user.corrections.find_by_id(params[:id])
        end
        if @correction.update_attributes(params[:correction])
          @correction.corrected_post = @post
          flash[:success] = "You have updated your correction successfully!"
          redirect_to correction_path(@correction)         
        else
          render 'edit'
        end
	end

	def show
        @correction = Correction.find(params[:id])        
        @post = @correction.corrected_post        
    end

	def index
	end
end
