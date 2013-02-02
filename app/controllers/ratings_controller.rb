class RatingsController < ApplicationController
	before_filter :signed_in_user, only: :create

    def create 
        #@post = Post.find(params[:rating][:rated_post_id])
        #if current_user.id == @post.user_id
            #redirect_to (@rating.post), :alert => "You cannot rate for your own photo"
        #else 
            @rating=current_user.ratings.build(params[:rating])             
            if @rating.save
                flash[:success] = "Thank you for rating this post!"        
                redirect_to root_url
            else 
                flash.now[:notice] = "Something went wrong. Please try again."
                redirect_to root_url
            end            
        #end
    end
end
