class StaticPagesController < ApplicationController
  def home
  	if signed_in?
      @post  = current_user.posts.build
      @feed_items = current_user.feed.visible.paginate(page: params[:page], per_page: 10, order: "updated_at DESC")
      @rating=current_user.ratings.build 
      @comment = current_user.comments.build
      @alarm = current_user.alarms.build
      @like = current_user.likes.build
    end
  end

  def help
  end

  def contact
  end
end
