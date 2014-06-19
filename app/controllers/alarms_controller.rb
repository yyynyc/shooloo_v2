class AlarmsController < ApplicationController
	before_filter :signed_in_user
    #load_and_authorize_resource

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
        if params.has_key?(:post_id)
            @post  = Post.find(params[:post_id])
        elsif params.has_key?(:post_id)
            @comment = Comment.find(params[:comment_id])
        end
        @alarm=current_user.alarms.build(params[:alarm])
        if @comment
            @alarm.alarmed_comment=@comment
        else
            @alarm.alarmed_post=@post
        end
        if @alarm.save
            flash[:success] = "Thank you for raising alarm! 
            	It is now taken out of the public view pending moderation."     
        	redirect_to root_url
        else 
        	flash[:notice] = "Sorry, something is wrong."  
        	render 'new'
        end            
    end

    def edit
        @alarm = Alarm.find(params[:id])
        @post  = @alarm.alarmed_post  
    end

    def update
        @alarm = Alarm.find(params[:id])
        @post  = @alarm.alarmed_post  
        if @alarm.update_attributes(params[:alarm])
          flash[:success] = "You have upddated your alarm successfully!"
          redirect_to alarmed_posts_path
        else
          render 'edit'
        end          
    end

    def destroy
        @alarm = Alarm.find(params[:id])
        unless @alarm.alarmed_post_id.nil?
            @post = Alarm.find(params[:id]).alarmed_post 
        else
            @comment = Alarm.find(params[:id]).alarmed_comment
        end 
        @alarm.destroy
        redirect_back_or alarmed_posts_path
    end

    def alarmed_posts
        @alarms = Alarm.all(order: 'created_at desc')  
    end
end
