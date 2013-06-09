class InvitesController < ApplicationController
	before_filter :signed_in_user
  load_and_authorize_resource
  respond_to :html, :js

  def new
    @invite = Invite.new
    @post  = Post.find(params[:post_id])  
  end

	def create
		@post = Post.find(params[:invite][:post_id])
		@invite = current_user.invites.create!(params[:invite])
		@invite.post = @post
    respond_to do |format|
    	format.html {redirect_to root_url }
        format.js
    end
	end
end