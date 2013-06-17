class CommentsController < ApplicationController
    before_filter :signed_in_user
    before_filter :correct_user, only: :destroy
    load_and_authorize_resource except: :new
    
	def index
        render 'new'
    end

    def new
        @comment = Comment.new
        @post  = Post.find(params[:post_id]) 
        @comments = @post.comments.paginate(page: params[:page],
            order: 'created_at DESC')
        @alarm = Alarm.new
        @rating = Rating.new
        @like = Like.new
        @liked_post = @like.liked_post
        @liked_comment = @like.liked_comment
    end

    def create
        @post  = Post.find(params[:post_id])
        @comment=current_user.comments.build(params[:comment])
        @comment.commented_post=@post            
        if @comment.save
            flash[:success] = "Hooray! Thank you for your comment. Now check your progress of getting a gift." 
            @comments = @post.comments.visible.paginate(page: params[:page], per_page: 5, 
                order: 'created_at DESC')      
            redirect_to new_post_comment_path(@post)
        else 
            raise "you need a post" if @post.nil?
            @post  = @comment.commented_post
            @alarm = @post.alarms.build
            @comments = @post.comments.visible.paginate(page: params[:page], per_page: 5, 
                order: 'created_at DESC')      
            render 'new'     
        end            
    end

    def show
    end

    def edit
        @post  = current_user.feed.find_by_id(params[:post_id])
        raise "you need a post" if @post.nil?
        @comment = @post.comments.find_by_id(params[:id])
        raise "you need a comment" if @comment.nil?
    end

    def update
        @comment = current_user.comments.find_by_id(params[:id])
        if @comment.update_attributes(params[:comment])
          flash[:success] = "You have updated your comment successfully!"
          redirect_to root_url
        else
          render 'edit'
        end
    end

    def destroy
        @comment = current_user.comments.find(params[:id])
        @comment.destroy
        redirect_to gift_receiving_path
    end

    def correct_user
        @comment = current_user.comments.find_by_id(params[:id])
        redirect_to root_url if @comment.nil?
    end
end
