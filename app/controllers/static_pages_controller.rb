class StaticPagesController < ApplicationController
  def home
  	if signed_in?
      @post  = current_user.posts.build
      @feed_items = current_user.feed.visible.paginate(page: params[:page], order: "updated_at DESC")
      @rating=current_user.ratings.build 
      @comment = current_user.comments.build
      @alarm = current_user.alarms.build
      @like = current_user.likes.build
      #@search = @feed_items.search(params[:q])
      #@feed_item = @search.result(:distinct => true)
    end
  end

  def help
  end

  def contact
  end
end
