class CommentsController < ApplicationController
    before_filter :signed_in_user
    skip_before_filter :signed_in_user, only: :new
    before_filter :correct_user, only: [:destroy, :edit, :update]
    before_filter :commenter_user, only: :index
    load_and_authorize_resource except: :new
    respond_to :html, :json
    before_filter :visible_post, only: [:new, :index]
    
	def index
        @comment = Comment.new
        @post  = Post.find(params[:post_id]) 
        @comments = @post.comments.paginate(page: params[:page], per_page: 10, 
            order: 'created_at DESC')
        @alarm = Alarm.new
        @rating = Rating.new
        @like = Like.new
        @liked_post = @like.liked_post
        @liked_comment = @like.liked_comment
    end

    def new
        if params.has_key?(:response_id)
            @response = Response.find(params[:response_id])
            @comment = @response.comments.build(params[:comment])
            @assignment = @response.assignment
            @post = @assignment.assigned_post  
        else
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
    end

    def create
        @post  = Post.find(params[:post_id])
        @comment=current_user.comments.build(params[:comment])
        @comment.commented_post=@post 
        @like = Like.new 
        if current_user.comment_count.nil?
            current_user.comment_count=0
            current_user.save!
        end          
        if @comment.save
            current_user.comment_count +=1
            current_user.save(validate: false)
            sign_in current_user
            @comment.commented_post = @post    
            if @post.comments_count.nil?
                @post.comments_count=0
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
            redirect_to post_comments_path(@post)
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
            redirect_to post_comments_path(@comment.commented_post)
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
        redirect_to post_comments_path(@post)
    end

    def correct_user
        @comment = Comment.find(params[:id])
        unless current_user == @comment.commenter || current_user.admin? 
            Flash[:error] = "Sorry, you can't edit that comment."
            redirect_to root_url 
        end
    end

    def commenter_user
        @post  = Post.find(params[:post_id]) 
        if current_user?(@post.user) || current_user.in?(@post.commenters) || current_user.role=="teacher" || current_user.admin?
            return true
        else
            redirect_to new_post_comment_path(@post)
        end
    end

    def visible_post
        @post  = Post.find(params[:post_id])
        if !@post.visible?
            if !signed_in?
                redirect_to posts_path 
            elsif current_user.role == "student" || current_user.role == "parent"
                redirect_to posts_path 
            end
        end
    end
end
