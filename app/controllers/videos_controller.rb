class VideosController < ApplicationController

	def new
		@video = Video.new
	end

	def create
		@video = Video.new(params[:video])
  		if @video.save  		
	        flash[:success] = "Video created successfully!"
	        redirect_to video_path(@video)
      	else
	  		render 'new'
	  	end
	end

	def edit
		@video = Video.find(params[:id])
	end

	def update
		@video = Video.find(params[:id])
		if @video.update_attributes(params[:video])
			flash[:success] = "Video updated successfully!"
			redirect_to video_path(@video)
		else
			render 'edit'
		end
	end

	def destroy
		@video.destroy
		flash[:notice] = "Video deleted."
		redirect_to videos_path
	end

	def index
		@search = Video.search(params[:q])
    	@videos = @search.result.order('created_at ASC')
    	@search.build_condition
	end

	def show
		@video = Video.find(params[:id])
		if request.path != video_path(@video)
		    redirect_to @video, status: :moved_permanently
		end
		@similar_videos = Video.where(category_id: @video.category.id).reject {|v| v.id==@video.id}
	end

	def pd
		@search = Video.where(teacher_pd: true).search(params[:q])
    	@videos = @search.result.order('created_at ASC')
    	@search.build_condition
	end
end
