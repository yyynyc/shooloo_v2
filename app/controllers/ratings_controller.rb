class RatingsController < ApplicationController
	before_filter :signed_in_user
    before_filter :correct_user,   only: :destroy
    load_and_authorize_resource 

    def index
    end

    def new
        @rating = Rating.new
        @post  = Post.find(params[:post_id]) 
        @alarm = Alarm.new 
        @like = Like.new  
        set_meta_tags title: 'Rate Common Core Math Word Problem #'+ @post.id.to_s, 
            description: 'Shooloo members give feedback on Common Core math 
                problem #' + @post.id.to_s,
            name: 'Shooloo Common Core math word problems',
            about: 'Math',
            keywords: 'Shooloo, common core, CCSS, math, word problem, rate, real life, cooperative learning',
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
        @rating = current_user.ratings.build(params[:rating])
        if @rating.save    
            current_user.rating_count +=1
            current_user.save(validate: false)
            sign_in current_user
            @rating.rated_post = @post
            @alarm =current_user.alarms.build(params[:alarm])
            @like = current_user.likes.build(params[:like])
            flash[:notice] = "Woohoo! you've earned some points! You are one step closer toward #{ActionController::Base.helpers.link_to "getting a gift", gift_receiving_path} from your friend.".html_safe 
            redirect_to root_path    
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
        set_meta_tags title: 'Edit Rating of Common Core Math Word Problem #'+ @post.id.to_s, 
            description: 'Shooloo members edit rating of Common Core math 
                problem #' + @post.id.to_s,
            name: 'Shooloo Common Core math word problems',
            about: 'Math',
            keywords: 'Shooloo, common core, CCSS, math, word problem, rate, edit, real life, cooperative learning',
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
        current_user.rating_count -=1
        current_user.save
        sign_in current_user
        redirect_to root_path
    end

    def correct_user
        @rating = current_user.ratings.find_by_id(params[:id])
        redirect_to root_url if @rating.nil?
    end
end
