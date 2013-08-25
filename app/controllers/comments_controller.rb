class CommentsController < ApplicationController
    before_filter :signed_in_user
    before_filter :correct_user, only: :destroy
    load_and_authorize_resource #except: :new
    
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
        set_meta_tags title: 'Critique Common Core Math Word Problem #'+ @post.id.to_s, 
            description: 'Shooloo members critique the reasoning of Common Core math 
                problem #' + @post.id.to_s,
            name: 'Shooloo Common Core math word problems',
            about: 'Math',
            keywords: 'Shooloo, common core, CCSS, math, word problem, critique, real life, cooperative learning',
            dateCreated: @post.updated_at.strftime('%m-%d-%Y').to_s,
            timeRequired: 'PT0H5M', 
            author: @post.user.screen_name.to_s,
            publisher: 'Shooloo Inc.',
            inLanguage: 'EN_US',
            typicalAgeRange: ['8-10', '10-12', '12-14'],
            interactivityType: ['Active', 'Expositive'],
            learningResourceType: ['Assessment', 'Discussion', 'On-Line', 'Worksheet'],
            useRightsUrl: 'http://creativecommons.org/licenses/by-nc-nd/3.0/',
            educationalRole: ['teacher', 'student', 'tutor', 'specialist', 'parent'],
            educationalUse: ['Assessment', 'Cooperative Learning', 'Discovery Learning', 'Interactive', 'Journaling', 'Peer Coaching', 'Peer Response', 'Problem Solving', 'Questioning', 'Reciprocal Teaching', 'Reflection', 'Reinforcement', 'Review', 'Writing'],
            educationalAlignment: 'Common Core State Standard',
            alignmentType: 'requires',
            targetName: ['CCSS.Math.Practice.MP3', 'CCSS.Math.Practice.MP4'],
            targetUrl: ['http://www.corestandards.org/Math/Practice/MP3', 'http://www.corestandards.org/Math/Practice/MP4'],
            targetDescription: ['Construct viable arguments and critique the reasoning of others', 'Model real life with mathematics']
    end

    def create
        @post  = Post.find(params[:post_id])
        @comment=current_user.comments.build(params[:comment])
        @comment.commented_post=@post            
        if @comment.save
            current_user.comment_count +=1
            current_user.save
            sign_in current_user
            if current_user == @post.user || !@comment.new_comment?
                flash[:success] = "Thank you for your comment."
            else
                flash[:notice] = "Hooray! you've earned some points! You are one step closer toward #{ActionController::Base.helpers.link_to "getting a gift", gift_receiving_path} from your friend.".html_safe 
            end
            @comments = @post.comments.visible.paginate(page: params[:page], 
                order: 'created_at DESC')      
            redirect_to new_post_comment_path(@post)
        else 
            raise "you need a post" if @post.nil?
            @post  = @comment.commented_post
            @alarm = @post.alarms.build
            @comments = @post.comments.visible.paginate(page: params[:page],  
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
        current_user.comment_count -=1
        current_user.save
        sign_in current_user
        redirect_to gift_receiving_path
    end

    def correct_user
        @comment = current_user.comments.find_by_id(params[:id])
        redirect_to root_url if @comment.nil?
    end
end
