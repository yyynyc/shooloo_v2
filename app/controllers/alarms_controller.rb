class AlarmsController < ApplicationController
	before_filter :signed_in_user

	def index
		@alarms = current_user.posts.hidden.all
        render 'users/show_alarmed_posts'
	end

	def new
        @alarm = Alarm.new
        @post  = Post.find_by_id(params[:post_id])    
    end

  	def create
        @post  = Post.find(params[:post_id])
        @alarm=current_user.alarms.build(params[:alarm])
        @alarm.alarmed_post=@post
        if @alarm.save
            flash[:success] = "Thank you for raising alarm about this post! 
            	It is now taken out of the public view pending moderation."     
        	redirect_back_or root_url
        else 
        	flash[:notice] = "Sorry, something is wrong."  
        	redirect_back_or root_url
        end            
    end
end
