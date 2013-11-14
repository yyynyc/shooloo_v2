class CommentsController < ApplicationController
    before_filter :signed_in_user
    before_filter :correct_user, only: [:destroy, :edit, :update]
    load_and_authorize_resource #except: :new
    respond_to :html, :json
    
	def index
        @comment = Comment.new
        @post  = Post.find(params[:post_id]) 
        @comments = @post.comments.paginate(page: params[:page], per_page: 20, 
            order: 'created_at DESC')
        @alarm = Alarm.new
        @rating = Rating.new
        @like = Like.new
        @liked_post = @like.liked_post
        @liked_comment = @like.liked_comment
        render 'new'
    end

    def new
        @comment = Comment.new
        @post  = Post.find(params[:post_id]) 
        @comments = @post.comments.paginate(page: params[:page], per_page: 20, 
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
        @like = Like.new           
        if @comment.save
            current_user.comment_count +=1
            current_user.save(validate: false)
            sign_in current_user
            @comment.commented_post = @post    
            if @post.comments_count.nil?
                @post.comments_count=0
                @post.save!(validate: false)
            end
            @post.comments_count +=1
            @post.save!(validate: false)     
            if current_user == @post.user || !@comment.new_comment?
                flash[:success] = "Thank you for your comment."
            else
                flash[:notice] = "Hooray! you've earned some points! You are one step closer toward #{ActionController::Base.helpers.link_to "getting a gift", gift_receiving_path} from your friend.".html_safe 
            end
            @comments = @post.comments.paginate(page: params[:page], 
                order: 'created_at DESC')      
            redirect_to new_post_comment_path(@post)
        else 
            raise "you need a post" if @post.nil?
            @post  = @comment.commented_post
            @alarm = @post.alarms.build
            @comments = @post.comments.paginate(page: params[:page],  
                order: 'created_at DESC')      
            render 'new'     
        end                            
    end

    def show
    end

    def edit
        # if current_user.admin?
        #     @post = Post.find_by_id(params[:post_id])
        # else
        #     @post  = current_user.feed.find_by_id(params[:post_id])
        # end
        # raise "you need a post" if @post.nil?
        # @comment = @post.comments.find_by_id(params[:id])
        # raise "you need a comment" if @comment.nil?
        if current_user.admin?
            @comment = Comment.find_by_id(params[:id])
        else
            @comment = current_user.comments.find_by_id(params[:id])
        end
    end

    def update
        if current_user.admin?
            @comment = Comment.find_by_id(params[:id])
        else
            @comment = current_user.comments.find_by_id(params[:id])
        end
        if @comment.update_attributes(params[:comment])
          flash[:success] = "You have updated your comment successfully!"
          if !@comment.commented_post.nil?
            redirect_to new_post_comment_path(@comment.commented_post)
          elsif !@comment.commented_lesson.nil?
            redirect_to lesson_comment_path(@comment.commented_lesson)
          end
        else
          render 'edit'
        end
    end

    def destroy
        @comment = current_user.comments.find(params[:id])
        @post = @comment.commented_post
        raise "can't find post" if @post.nil?
        Event.create!(benefactor_id: @comment.commenter_id, 
          beneficiary_id: @post.user.id, 
          event: "delete comment", value: ShoolooV2::COMMENT_DELETE)
        if @post.user.admin? || @post.user.role == "teacher"
          Event.create!(benefactor_id: @comment.commenter_id, 
            beneficiary_id: @post.user.id, 
            event: "delete comment bounus", value: ShoolooV2::COMMENT_BONUS_DELETE)
        end 
        @comment.destroy
        current_user.comment_count -=1
        current_user.save(validate: false)
        sign_in current_user         
        @post.comments_count -=1
        @post.save!(validate: false) 
        flash[:notice] = "Sorry... You've just #{ActionController::Base.helpers.link_to "lost some points", gift_receiving_path} from your friend.".html_safe 
        redirect_to new_post_comment_path(@post)
    end

    def correct_user
        @comment = Comment.find(params[:id])
        unless current_user == @comment.commenter || current_user.admin? 
            Flash[:error] = "Sorry, you can't edit that comment."
            redirect_to root_url 
        end
    end
end
