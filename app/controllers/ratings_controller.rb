class RatingsController < ApplicationController
	before_filter :signed_in_user
    before_filter :correct_user,   only: :destroy
    load_and_authorize_resource except: :new

    def index
    end

    def new
        @rating = Rating.new
        @post  = Post.find(params[:post_id]) 
        @alarm = Alarm.new 
        @like = Like.new     
    end

    def create
        @rating = current_user.ratings.build(params[:rating])
        if @rating.save
            @rating.rated_post = @post
            @alarm =current_user.alarms.build(params[:alarm])
            @like = current_user.likes.build(params[:like])
            flash[:success] = "Woohoo! You've just earned more points! You are one step closer toward getting a gift." 
            redirect_to gift_receiving_path    
        else
            @post = @rating.rated_post
            raise "you need a post" if @post.nil?
            @alarm =current_user.alarms.build(params[:alarm])
            @like = current_user.likes.build(params[:like])            
            render 'new'     
        end            
    end

    def edit
        @post = current_user.rated_posts.find(params[:post_id]) 
        raise "you need a post" if @post.nil?
        @rating = @post.ratings.find_by_id(params[:id])
        raise "you need a rating" if @rating.nil?
        @alarm = @post.alarms.build
        @like = @post.likes.build
    end

    def update
        @rating = current_user.ratings.find_by_id(params[:id])
        if @rating.update_attributes(params[:rating])
          flash[:success] = "You have updated your rating successfully!"
          redirect_to root_url
        else
          @post = @rating.rated_post
          @alarm = @post.alarms.build
          @like = @post.likes.build
          render 'edit'
        end
    end

    def destroy
        @rating.destroy
        redirect_to gift_receiving_path
    end

    def correct_user
        @rating = current_user.ratings.find_by_id(params[:id])
        redirect_to root_url if @rating.nil?
    end
end
