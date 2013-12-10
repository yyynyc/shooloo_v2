class KeepsController < ApplicationController
	before_filter :signed_in_user
  load_and_authorize_resource

  def new
    @keep = Keep.new
    @post = Post.find(params[:post_id])
  end

	def create
    @keep = current_user.keeps.create!(params[:keep])
    if @keep.save
      @post = @keep.kept_post
      flash[:success] = "Post saved for future assignment!"
      redirect_to root_path
    else
      @post = @keep.kept_post
      render 'new'
    end
	end

  def destroy
  end
end