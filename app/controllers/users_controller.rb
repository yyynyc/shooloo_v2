require 'will_paginate/array'

class UsersController < ApplicationController
  before_filter :signed_in_user
  skip_before_filter :signed_in_user, only: [:new, :create, :signup_student]
  before_filter :correct_user, only: [:edit, :update, :student_homework, :student_common_core, 
    :report_card, :responses, :assignments, :grading_results, :past_due_assignments, 
    :teacher_dashboard, :keeps]
  before_filter :admin_user, only: [:destroy]

  def my_abilities
    if params[:error]
      flash.now[:error] = "Sorry, you need to #{ActionController::Base.helpers.link_to "get authorization", new_authorization_path} first to gain access to this functionality.".html_safe
    end
    set_meta_tags title: 'My Powers', 
        description: "Shooloo member's access to various activities",
        noindex: true,
        nofollow: true            
  end

  def new
  	@user = User.new
    @user.self_signup = true
  end

  def signup_student
    @user = User.new
    @user.create_student = true
    @user.self_signup = true
  end

  def create
    @user = User.new(params[:user])
    @user.self_signup = true
    if @user.role == "student"
      @user.create_student = true
    end
    if @user.save
      sign_in @user
      unless @user.role == "student"
        flash[:error] = "Hooray! You've just earned 10 points. Tell us who referred you or hit the Skip button."
        redirect_to new_introduction_path
      else
        flash[:error] = "Hooray! You've just earned 10 points. Complete the form below."
        redirect_to edit_user_path(@user)
      end
    else
      if @user.role=="student"
        render 'signup_student'
      else
        render 'new'
      end
    end
  end

  def index
    @search = User.visible.search(params[:q])
    @users = @search.result(order: 'created_at DESC')
    @users_paginate = @search.result.paginate(page: params[:page], 
      per_page: 30, order: 'post_count DESC, comment_count DESC, rating_count DESC, following_count DESC, gift_received_count DESC, created_at ASC')
    @search.build_condition
    respond_to do |format|
      format.html { @users_paginate }
      format.csv { send_data @users.to_csv }
      format.xls
    end
    set_meta_tags title: 'Members', 
        description: "index of Shooloo members",
        noindex: true,
        nofollow: true 
  end

  def hidden
    @search_hidden = User.hidden.search(params[:q])
    @users_hidden_paginate = @search_hidden.result.paginate(page: params[:page], 
          per_page: 30, order: 'created_at DESC')
    @users_hidden = User.hidden.all(order: 'created_at DESC')
    @search_hidden.build_condition
    respond_to do |format|
      format.html { @users_hidden_paginate }
      format.csv { send_data @users_hidden.to_csv }
      format.xls
    end
    # render 'hidden'
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

  def edit
    @user = User.find(params[:id])
    set_meta_tags title: 'Update My Information', 
        description: "Shooloo member updates personal information",
        noindex: true,
        nofollow: true 
  end

  def update
    @user.update_attributes(params[:user])
    if @user.state == "incomplete"
      if params[:button] == "save"
        if @user.finish
          if @user.role == "teacher" 
            if @user.authorized_users.blank?
              flash[:success] = "Success! Import your student roster or #{ActionController::Base.helpers.link_to "skip for now", posts_path}."
              redirect_to new_user_import_path
            else
              flash[:success] = "Success! "
              redirect_to posts_path
            end
          else
            flash[:success] = "Information updated successfully!"
            redirect_to posts_path
          end
        else
          render 'edit'
        end
      elsif params[:button] == "admin_edit"
        if @user.admin_edit
          redirect_to search_hidden_users_path
        else
          render 'edit'
        end
      end
    else
      if params[:button] == "save" 
        if @user.save
          flash[:success] = "Information updated successfully!"
          redirect_to root_path
        else
          render 'edit'
        end
      elsif params[:button] == "admin_edit" 
        if @user.admin_edit
          flash[:success] = "Information updated successfully!"
          redirect_to search_hidden_users_path
        else
          render 'edit'
        end
      end
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

  def draft_posts
    @user = User.find(params[:id])
    @posts = @user.posts.where(state: "draft").paginate(page: params[:page], per_page: 10, order: "created_at DESC")
  end

  def submitted_posts
    @user = User.find(params[:id])
    @posts = @user.posts.where(state: "submitted").paginate(page: params[:page], per_page: 2000, order: "created_at DESC")
  end

  def posts
    @user = User.find(params[:id])
    if current_user?(@user) || current_user.admin?
      @posts = @user.posts.where(state: ["verified", "published", "old", "revised"], toreview: ["false", nil]).paginate(page: params[:page], per_page: 10, order: "created_at DESC")
      @to_reviews = @user.posts.where(toreview: true).order("created_at DESC")
    else
      @posts = @user.posts.where(state: ["verified", "published", "old", "revised"]).paginate(page: params[:page], per_page: 10, order: "created_at DESC")
    end
    @drafts =  @user.posts.where(state: "draft").order("created_at DESC")
    @submissions =  @user.posts.where(state: "submitted").order("created_at DESC")
    @comment=current_user.comments.build(params[:comment])
    @alarm = current_user.alarms.build(params[:alarm])
    @like = current_user.likes.build(params[:like])
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
      per_page: 10, order: "created_at DESC")
    @rating=current_user.ratings.build(params[:rating])
    @post  = current_user.posts.build
    @alarm = current_user.alarms.build
    @like = current_user.likes.build
    @comment=current_user.comments.build(params[:comment])
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
    # @commented_posts = @user.comments.order('created_at DESC').collect(
    #   &:commented_post).keep_if{ |x| x.visible == true }.uniq.paginate(
    #   page: params[:page], per_page: 10)
    @commented_posts = @user.commented_posts.where(state: ["published", "verified", "old", "revised"]).paginate(page: params[:page], 
     per_page: 10, order: "updated_at DESC")
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
      if @user.grade <= 8
        @domains = Domain.where(level_id: (@user.grade+1))    
        @standards = Standard.joins(:posts).where("posts.user_id =? AND posts.level_id != ?", @user.id, (@user.grade+1)).uniq.order('standards.short ASC')
      else
        @domains = Domain.where(level_id: 10)    
        @standards = Standard.joins(:posts).where("posts.user_id =? AND posts.level_id != ?", @user.id, 10).uniq.order('standards.short ASC')
      end
    else
      @standards = Standard.joins(:posts).where("posts.user_id =?", @user.id).uniq.order('standards.short ASC')
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

  def student_homework
    @user = User.find(params[:id])
    @students = @user.authorized_users.order('grade DESC', 'last_name ASC')
    # @homeworks = Homework.where(user_id.in?(@user.authorized_users))
    # respond_to do |format|
    #   format.html
    #   format.csv { send_data @homeworks.to_csv }
    #   format.xls
    # end
    set_meta_tags title: "My Students' Homework Progress", 
        description: "#{@user.screen_name}'s students' Homework Tracker",
        noindex: true,
        nofollow: true
  end

  def lessons
    @user = User.find(params[:id])
    @lessons = @user.lessons.paginate(page: params[:page], per_page: 20, order: "created_at DESC")
    @lesson = @user.lessons.build(params[:lesson])
    @like = current_user.likes.build(params[:like])
    @comment = current_user.comments.build(params[:comment])
  end

  def show_activity
    @my_activities = Activity.where(recipient_id: current_user.id).paginate(page: params[:page], 
      per_page: 15, order: 'position DESC, created_at DESC')
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

  def assignments
    @user = User.find(params[:id])
    @assignments = @user.assignments.paginate(page: params[:page], 
      per_page: 10, order: 'end_date DESC, start_date ASC')
  end

  def responses
    @user = User.find(params[:id])
    @responses = @user.reverse_responses.paginate(page: params[:page], 
      per_page: 10, order: 'completed ASC')
  end

  def report_card
    @user = User.find(params[:id])
    @standards = @user.reverse_gradings.map(&:standard).compact.uniq.sort
  end

  def teacher_dashboard
    @user = User.find(params[:id])
    @students = @user.authorized_users
    @assigned_homeworks = @user.responses
    @ungraded_posts = Post.where(state: "submitted", graded: false).keep_if{|p| p.response.in?(@user.responses)}
    @ungraded_comments = Comment.where(graded: false).keep_if{|c| c.response.in?(@user.responses)}
    @assigned_homeworks_due = @assigned_homeworks.where("assignments.end_date <?", Time.now)
    @past_due_homeworks = @assigned_homeworks_due.where(completed: false)
    @past_due_students = @past_due_homeworks.map(&:assignee).compact.uniq.sort_by{|s| [s.grade, s.last_name]}   
    
    @past_homeworks = User.find(params[:id]).past_homeworks
    @no_post_students = User.find(params[:id]).no_post_students
    @ungraded_students = User.find(params[:id]).ungraded_students
    @below_grade_students = User.find(params[:id]).below_grade_students
    @no_login_students = User.find(params[:id]).no_login_students
  end

  def past_due_assignments
    @user = User.find(params[:id])
    @past_assignments = @user.assignments.where("end_date<?", Time.now).paginate(page: params[:page], 
      per_page: 5, order: 'end_date DESC, start_date ASC')
    @past_due_assignments = @past_assignments.includes(:responses).where("responses.completed" => false)
    @assigned_homeworks = Response.joins(:assignment).where(assignments: {assigner_id: 
      @user.id})
    @assigned_homeworks_due = @assigned_homeworks.where("assignments.end_date <?", 
      Time.now)
    @past_due_homeworks = @assigned_homeworks_due.where(completed: false)
    @past_due_students = @past_due_homeworks.map(&:assignee).compact.uniq.sort_by{|s| [s.grade, s.last_name]}
    @reminder = Reminder.new 
  end

  def grading_results
    @user = User.find(params[:id])
    @past_assignments = @user.assignments.order('end_date DESC, start_date ASC')
    @students = @user.authorized_users.order('grade ASC, last_name ASC').keep_if{|u| u.reverse_responses.any?}
  end

  def keeps
    @user = User.find(params[:id])
    @keeps = @user.keeps.order('created_at DESC')
    @like = Like.new
    @comment = Comment.new
    @invite = Invite.new
    @alarm = Alarm.new
    @rating = Rating.new
  end

  private
    
    def correct_user
      @user = User.find(params[:id])
      unless current_user?(@user) || current_user.admin? || current_user.in?(@user.authorizers)
        redirect_to(root_path) 
      end
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
