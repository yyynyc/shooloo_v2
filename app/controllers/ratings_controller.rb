class RatingsController < ApplicationController
	before_filter :signed_in_user, only: [:create, :destroy]
    before_filter :correct_user,   only: :destroy

    def edit
    end

    def create 
        @rating=current_user.ratings.build(params[:rating])             
        if @rating.save
            flash[:success] = "Thank you for rating this post!"        
            redirect_to root_url
        else 
            flash.now[:notice] = "Something went wrong. Please try again."
            #redirect_to @rating
            redirect_to root_url
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
