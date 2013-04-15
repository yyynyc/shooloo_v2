class CommentsController < ApplicationController
    before_filter :signed_in_user
    
	def index
    end

    def new
        @comment = Comment.new
        @post  = Post.find_by_id(params[:post_id]) 
        @comments = @post.comments.paginate(page: params[:page],
            order: 'created_at DESC')
        @alarm = Alarm.new
        @rating = Rating.new
    end

    def create
        @post  = Post.find(params[:post_id])
        @comment=current_user.comments.build(params[:comment])
        @comment.commented_post=@post            
        if @comment.save
            flash[:success] = "Thank you for commenting this post!" 
            @comments = @post.comments.visible.paginate(page: params[:page], per_page: 5, 
                order: 'created_at DESC')      
            redirect_to new_post_comment_path(@post)
        else 
            raise "you need a post" if @post.nil?
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
        #track_activity @comment
        redirect_to new_post_comment_path(@comment.commented_post)
    end

    def correct_user
        @comment = current_user.comments.find_by_id(params[:id])
        redirect_to root_url if @comment.nil?
    end
end
