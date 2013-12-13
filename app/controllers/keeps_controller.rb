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

  def edit
    if current_user.admin? 
      @keep = Keep.find(params[:id])
    else
      @keep = current_user.keeps.find_by_id(params[:id])
    end 
    @post = @keep.kept_post   
  end

  def update
    if current_user.admin? 
      @keep = Keep.find(params[:id])
    else
      @keep = current_user.keeps.find_by_id(params[:id])
    end 
    @post = @keep.kept_post 
    if @keep.update_attributes(params[:keep])
      flash[:success] = "You have upddated your save note successfully!"
      redirect_to keeps_user_path(current_user)
    else
      render 'edit'
    end
  end

  def destroy
    @keep.destroy
    flash[:success] = "Post removed from saved folder."
    redirect_to keeps_user_path(current_user)
  end
end