class VideosController < ApplicationController
	before_filter :signed_in_user, only: [:new, :edit, :destroy, :premium]
	load_and_authorize_resource

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
		if !signed_in?
			@search = Video.search(params[:q])
		elsif current_user.role == "student"
			@search = Video.where(student: true).search(params[:q])
		else
			@search = Video.search(params[:q])
		end
    	@videos = @search.result.order('position ASC')
    	@search.build_condition
	end

	def show
		@video = Video.find(params[:id])
		if request.path != video_path(@video)
		    redirect_to @video, status: :moved_permanently
		end
		if !signed_in?
			@videos = Video.order('position ASC').reject {|v| v.id==@video.id}
		elsif current_user.role == "student"
			@videos = Video.where(student: true).order('position ASC').reject {|v| v.id==@video.id}
		else
			@videos = Video.order('position ASC').reject {|v| v.id==@video.id}
		end		
		@similar_videos = Video.where(category_id: @video.category.id).reject {|v| v.id==@video.id}
	end

	def premium
		@video = Video.find(params[:video_id])
		if request.path != video_path(@video)
		    redirect_to @video, status: :moved_permanently
		end
		if signed_in? && current_user.role == "student"
			@videos = Video.where(student: true).order('position ASC').reject {|v| v.id==@video.id}
		else
			@videos = Video.order('position ASC').reject {|v| v.id==@video.id}
		end		
	end

	def pd
		@search = Video.search(params[:q])
    	@videos = @search.result.order('position ASC')
    	@search.build_condition
	end
end
