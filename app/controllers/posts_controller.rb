class PostsController < ApplicationController
	before_filter :signed_in_user
  before_filter :correct_user,   only: :destroy
  load_and_authorize_resource
  
  def index
    @search = Post.visible.search(params[:q])
    @posts = @search.result.visible.paginate(page: params[:page], per_page: 30, order: 'updated_at DESC')
    @search.build_condition
    @like = current_user.likes.build(params[:like])
    set_meta_tags title: 'Common Core Math Word Problems', 
            description: 'Index of all Common Core math word problems published on Shooloo',
            name: 'Shooloo Common Core math word problems',
            about: 'Math',
            keywords: 'Shooloo, common core, CCSS, math, word problem, critique, rate, real life, cooperative learning',
            dateCreated: Time.now.strftime('%m-%d-%Y').to_s,
            timeRequired: 'PT0H5M', 
            author: 'students',
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

  def show
    index
    render :action => 'index'
    set_meta_tags title: 'Common Core Math Word Problems', 
            description: 'Index of all Common Core math word problems published on Shooloo',
            name: 'Shooloo Common Core math word problems',
            about: 'Math',
            keywords: 'Shooloo, common core, CCSS, math, word problem, critique, rate, real life, cooperative learning',
            dateCreated: Time.now.strftime('%m-%d-%Y').to_s,
            timeRequired: 'PT0H5M', 
            author: 'students',
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
  	@post = current_user.posts.build(params[:post])
    if @post.save
      flash[:success] = "Fantastic! Thank you for your post. 
        Now try to gather some fans for your posts."
      redirect_to root_path
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def edit
    @post = current_user.posts.find_by_id(params[:id])
    set_meta_tags title: 'Edit Common Core Math Word Problem #'+ @post.id.to_s, 
            description: 'Shooloo member edit Common Core math 
                problem #' + @post.id.to_s,
            name: 'Shooloo Common Core math word problems',
            about: 'Math',
            keywords: 'Shooloo, common core, CCSS, math, word problem, edit, real life, review',
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
    @post = current_user.posts.find_by_id(params[:id])
    if     
      @post.update_attributes(params[:post])
      flash[:success] = "You have upddated your post successfully!"
      redirect_to new_post_comment_path(@post)
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
     flash[:success] = "Sorry, you've just lost some points."
    redirect_to root_url
  end

  def correct_user
      @post = current_user.posts.find_by_id(params[:id])
      redirect_to root_url if @post.nil?
  end
end
