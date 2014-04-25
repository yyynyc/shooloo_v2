class HstandardsController < ApplicationController
  	before_filter :signed_in_user
	load_and_authorize_resource

  def new
  	@hstandard = Hstandard.new
  end

  def create
  	@hstandard = Hstandard.new(params[:hstandard])
  	if @hstandard.save
  		flash[:success] = "Success!"
  		redirect_to levels_path
  	else
  		render 'new'
  	end
  end

  def edit
  	@hstandard = Hstandard.find(params[:id])
  end

  def update
  	@hstandard = Hstandard.find(params[:id])
  	if @hstandard.update_attributes(params[:hstandard])
  		flash[:success] = "Success!"
  		redirect_to levels_path
  	else
  		render 'edit'
  	end
  end

  def show
  end
end

