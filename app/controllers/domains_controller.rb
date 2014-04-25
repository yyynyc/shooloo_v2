class DomainsController < ApplicationController
	before_filter :signed_in_user
	load_and_authorize_resource

  def new
  	@domain = Domain.new
  end

  def create
  	@domain = Domain.new(params[:domain])
  	if @domain.save
  		flash[:success] = "Success!"
  		redirect_to levels_path
  	else
  		render 'new'
  	end
  end

  def edit
  	@domain = Domain.find(params[:id])
  end

  def update
  	@domain = Domain.find(params[:id])
  	if @domain.update_attributes(params[:domain])
  		flash[:success] = "Success!"
  		redirect_to levels_path
  	else
  		render 'edit'
  	end
  end

  def show
  end
end
