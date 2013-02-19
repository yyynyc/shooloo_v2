class RatingsController < ApplicationController
	before_filter :signed_in_user, only: [:create, :destroy]
    before_filter :correct_user,   only: :destroy

    def index
    end

    def new
        @rating = Rating.new
        @post  = Post.find_by_id(params[:post_id])       
    end

    def create

        @rating=current_user.ratings.build(params[:rating])             
        if @rating.save
            flash[:success] = "Thank you for rating this post!" 
            redirect_to rated_posts_user_path(current_user)    
        else 
            @post  = @rating.rated_post
            render 'new'     
        end            
    end

    def edit
        @post  = current_user.feed.find_by_id(params[:post_id])
        raise "you need a post" if @post.nil?
        @rating = @post.ratings.find_by_id(params[:id])
        raise "you need a rating" if @rating.nil?
    end

    def update
        @rating = current_user.ratings.find_by_id(params[:id])
        if @rating.update_attributes(params[:rating])
          flash[:success] = "You have updated your rating successfully!"
          redirect_to root_url
        else
          render 'edit'
        end
    end

    def destroy
        @rating.destroy
        redirect_to root_url
    end

    def correct_user
        @rating = current_user.ratings.find_by_id(params[:id])
        redirect_to root_url if @rating.nil?
    end
end
