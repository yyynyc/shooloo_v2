class InvitesController < ApplicationController
	before_filter :signed_in_user
  load_and_authorize_resource
  respond_to :html, :js

	def create
		@post = Post.find(params[:invite][:invited_post_id])
		current_user.invite!(@post)
    respond_to do |format|
    	format.html {redirect_to root_url }
        format.js
    end
	end
end