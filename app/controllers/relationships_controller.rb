class RelationshipsController < ApplicationController
  before_filter :signed_in_user
  #load_and_authorize_resource

  respond_to :html, :js

  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user)
    if current_user.following_count.nil?
      current_user.following_count = 0
    end
    current_user.following_count += 1
    current_user.save
    sign_in current_user
    @user.follower_count +=1
    @user.save
    respond_with @user
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
        current_user.following_count -=1
    current_user.save
    sign_in current_user
    @user.follower_count -=1
    @user.save
    respond_with @user
  end
end