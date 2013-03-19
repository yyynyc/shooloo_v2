class AlarmsController < ApplicationController
	before_filter :signed_in_user

	def index
		@user = current_user
		@post = Post.new
		@alarms = @alarmed_posts = current_user.posts.hidden
		@alarmed_posts = @alarms.paginate(page: params[:page], per_page: 30)
		if @alarms.empty?
			@alarmed_post = Post.new
		else
			@alarmed_post = @alarms.first
		end
		@alarm = Alarm.new
        render 'users/show_alarmed_posts'
	end

	def new
        @alarm = Alarm.new
        @post  = Post.find_by_id(params[:post_id])    
        @comment = Comment.find_by_id(params[:comment_id])
    end

  	def create
        @post  = Post.find(params[:post_id])
        @comment = Comment.find_by_id(params[:comment_id])
        @alarm=current_user.alarms.build(params[:alarm])
        
        if @comment
            @alarm.alarmed_comment=@comment
        else
            @alarm.alarmed_post=@post
        end
        if @alarm.save
            track_activity @alarm
            flash[:success] = "Thank you for raising alarm about this post! 
            	It is now taken out of the public view pending moderation."     
        	redirect_to root_url
        else 
        	flash[:notice] = "Sorry, something is wrong."  
        	redirect_back_or root_url
        end            
    end
end
