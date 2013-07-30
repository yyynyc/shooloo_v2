require 'will_paginate/array'

class UsersController < ApplicationController
  before_filter :signed_in_user
  skip_before_filter :signed_in_user, only: [:new, :create]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: [:destroy]

  def my_abilities
    if params[:error]
      flash.now[:error] = "Sorry, you need to #{ActionController::Base.helpers.link_to "get authorization", new_authorization_path} or #{ActionController::Base.helpers.link_to "get referral", new_referral_path} first to gain access to this functionality.".html_safe
    end
    set_meta_tags title: 'My Powers', 
        description: "Shooloo member's access to various activities",
        noindex: true,
        nofollow: true            
  end

  def new
  	@user = User.new
    @authorization = @user.authorizations.build
    set_meta_tags title: 'Sign Up', 
        description: 'Shooloo member sign up',
        keywords: 'Shooloo, sign up'
  end

  def index
    @search = User.visible.search(params[:q])
    @users = @search.result.paginate(page: params[:page], 
      per_page: 30, order: 'screen_name ASC')
    @search.build_condition
    set_meta_tags title: 'Members', 
        description: "index of Shooloo members",
        noindex: true,
        nofollow: true 
  end

  def hidden
    @search_hidden = User.hidden.search(params[:q])
    @users_hidden = @search_hidden.result.paginate(page: params[:page], 
      per_page: 30, order: 'screen_name ASC')
    @search_hidden.build_condition
    render 'hidden'
    set_meta_tags title: 'Hidden Users', 
        description: "List of Shooloo users that have not been approved of memberships",
        noindex: true,
        nofollow: true 
  end

  def show
    index
    render :action =>'index'
    set_meta_tags title: 'Members', 
        description: "index of Shooloo members",
        noindex: true,
        nofollow: true 
  end

  def create
  	@user = User.new(params[:user])
  	if @user.save
  		sign_in @user
      flash[:error] = "Welcome! You have not completed your profile. To gain full access to all functionalities, #{ActionController::Base.helpers.link_to "complete your information here", edit_user_path(current_user)}.". html_safe
      redirect_to posts_path
  	else
  		render 'new'
  	end
  end

  def edit
    @user = current_user
    set_meta_tags title: 'Update My Information', 
        description: "Shooloo member updates personal information",
        noindex: true,
        nofollow: true 
  end

  def update
    if @user.update_attributes(params[:user])
      if @user.authorizations.any?
        flash[:success] = "Information updated successfully!"
      else 
        flash[:notice] = "Information updated successfully! #{ActionController::Base.helpers.link_to "Get authorization", new_authorization_path} to gain full access to all functionalities.".html_safe
      end
      sign_in @user
      redirect_to my_abilities_path
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_path
  end

  def following    
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    @title = "Shooloo Members that #{@user.screen_name} Follows"
    @description = "List of Shooloo members that #{@user.screen_name} follows"
    render 'show_follow'
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    @title = "#{@user.screen_name}'s' Followers"
    @description = "List of Shooloo members that follow #{@user.screen_name}"
    render 'show_follow'
  end

  def posts
    @user = User.find(params[:id])
    @posts = @user.posts.visible.paginate(page: params[:page], per_page: 10, order: "updated_at DESC")
    @post = @user.posts.build(params[:post])
    @rating=current_user.ratings.build(params[:rating])
    @alarm = current_user.alarms.build(params[:alarm])
    @like = current_user.likes.build(params[:like])
    @subject = Subject.all
    @levels = Level.all
    @domains = Domain.all
    @standards = Standard.all
    set_meta_tags title: "Common Core Math Word Problems Written by #{@user.screen_name}", 
        description: "List of common core math word problems written by #{@user.screen_name}",
        name: 'Shooloo Common Core math word problems',
        about: 'Math',
        keywords: 'Shooloo, common core, CCSS, math, word problem, student, real life, cooperative learning',
        dateCreated: @user.created_at.strftime('%m-%d-%Y').to_s,
        timeRequired: 'PT0H5M', 
        author: @user.screen_name.to_s,
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


  def rated_posts
    @user = User.find(params[:id])
    @rated_posts = @user.rated_posts.visible.paginate(page: params[:page], 
      per_page: 10, order: "updated_at DESC")
    @rating=current_user.ratings.build(params[:rating])
    @post  = current_user.posts.build
    @alarm = current_user.alarms.build
    @like = current_user.likes.build
    @subject = Subject.all
    @levels = Level.all
    @domains = Domain.all
    @standards = Standard.all
    render 'show_rated_posts'
    set_meta_tags title: "Common Core Math Word Problems Rated by #{@user.screen_name}", 
        description: "List of common core math word problems rated by #{@user.screen_name}",
        name: 'Shooloo Common Core math word problems',
        about: 'Math',
        keywords: 'Shooloo, common core, CCSS, math, word problem, student, real life, cooperative learning',
        dateCreated: @user.created_at.strftime('%m-%d-%Y').to_s,
        timeRequired: 'PT0H5M', 
        author: @user.screen_name.to_s,
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

  def commented_posts
    @user = User.find(params[:id])
    @commented_posts = @user.comments.order('created_at DESC').collect(
      &:commented_post).keep_if{ |x| x.visible == true }.uniq.paginate(
      page: params[:page], per_page: 10)
    #@commented_posts = @user.commented_posts.visible.paginate(page: params[:page], 
    #  per_page: 10, order: "updated_at DESC")
    @comment=current_user.comments.build(params[:comment])
    @post  = current_user.posts.build
    @alarm = current_user.alarms.build
    @like = current_user.likes.build
    @subject = Subject.all
    @levels = Level.all
    @domains = Domain.all
    @standards = Standard.all
    render 'show_commented_posts'
    set_meta_tags title: "Common Core Math Word Problems Critiqued by #{@user.screen_name}", 
        description: "List of common core math word problems commented by #{@user.screen_name}",
        name: 'Shooloo Common Core math word problems',
        about: 'Math',
        keywords: 'Shooloo, common core, CCSS, math, word problem, critique, real life, cooperative learning',
        dateCreated: @user.created_at.strftime('%m-%d-%Y').to_s,
        timeRequired: 'PT0H5M', 
        author: @user.screen_name.to_s,
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

  def alarmed_posts
    @user = User.find(params[:id])
    @alarmed_posts = @user.posts.hidden.paginate(page: params[:page], order: "updated_at DESC")
    @alarm=current_user.alarms.build(params[:alarm])
    @post  = current_user.posts.build
    @like = current_user.likes.build
    @subject = Subject.all
    @levels = Level.all
    @domains = Domain.all
    @standards = Standard.all
    render 'show_alarmed_posts'
    set_meta_tags title: "Invisible Math Problems Written by #{@user.screen_name}", 
        description: "List of math problems written by #{@user.screen_name} but have been alarmed",
        noindex: true,
        nofollow: true
  end

  def common_core_I_can
    @user = User.find(params[:id])
    @post  = current_user.posts.build
    if !@user.grade.nil?
      @domains = Domain.where(level_id: (@user.grade+1))    
      @standards = Standard.joins(:posts).where("posts.user_id = ? AND posts.level_id != ?", @user.id, (@user.grade+1)).order('standards.short ASC')
    else
      @standards = Standard.joins(:posts).where("posts.user_id = ? ", @user.id).order('standards.short ASC')
    end
    render 'common_core_I_can'
    set_meta_tags title: "Common Core Math I-Can Journal by #{@user.screen_name}", 
        description: "#{@user.screen_name}'s I-Can journal based on the Common Core State Standards for Math",
        noindex: true,
        nofollow: true
  end

  def student_common_core
    @user = User.find(params[:id])
    @students = @user.authorized_users.order('grade ASC', 'last_name ASC')
    render 'student_common_core'
    set_meta_tags title: "My Students' Common Core Math I-Can Journals", 
        description: "#{@user.screen_name}'s students' I-Can journals based on the Common Core State Standards for Math",
        noindex: true,
        nofollow: true
  end

  def show_activity
    @my_activities = Activity.where(recipient_id: current_user.id).paginate(page: params[:page], 
      per_page: 30, order: 'created_at DESC')
    set_meta_tags title: "My News Alerts", 
        description: "Shooloo member's activity feed",
        noindex: true,
        nofollow: true
  end

  def change_password
    @user = current_user
    set_meta_tags title: "Update My Password", 
        description: "Shooloo member change password",
        noindex: true,
        nofollow: true
  end
  
  def update_password
    @user = current_user
    @user.updating_password = true
    if @user.authenticate(params[:user][:old_password])
      sign_in @user
      @user.password_confirmation = params[:user][:password_confirmation]
      @user.password = params[:user][:password]
      if @user.save
        sign_in @user
        flash[:notice] = "Password successfully updated!"
        redirect_to root_path
      else 
        render 'change_password'
      end  
    else
      flash.now[:error] = "Old password is incorrect." 
      render 'change_password'
    end
  end

  

  private
    
    def correct_user
      @user = User.find(params[:id]) 
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
