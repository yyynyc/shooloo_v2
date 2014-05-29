class StaticPagesController < ApplicationController
  def home
  	if signed_in?
      @post  = current_user.posts.build
      @correction_drafts =  current_user.corrections.where(state: "draft")
      @drafts =  current_user.posts.where(state: "draft").order("created_at DESC")
      @submissions =  current_user.posts.where(state: "submitted").order("created_at DESC")
      @feed_items = current_user.feed.visible.paginate(page: params[:page], per_page: 10, order: "updated_at DESC")
      @rating=current_user.ratings.build 
      @comment = current_user.comments.build
      @alarm = current_user.alarms.build
      @like = current_user.likes.build
      @levels = Level.all
      @domains = Domain.all
      @standards = Standard.all
      if current_user.role == "editor"
        @checks = current_user.checks.order('created_at ASC')        
        @submissions = Post.where(state: "submitted").order("competition DESC, created_at ASC")
        @publications = Post.where(state: "old").paginate(page: params[:page], 
          per_page: 2000, order: "created_at DESC")
        @publications_middle = @publications.keep_if{|p| p.user.grade > 6}
        @publications_lower = @publications.keep_if{|p| p.user.grade < 7}
        @re_corrected = current_user.corrections.where(state: "revised").order('created_at ASC').order('created_at ASC')
        @corrected = current_user.corrections.where(state: "submitted").order('created_at ASC')
        @corrections = current_user.corrections.where(state: ["submitted", "revised"])
      end
    end
    set_meta_tags title: 'Common Core Math Problems Created by Students for Students', 
            description: "World's largest repository of student-authored common core math word problems",
            name: 'Shooloo Common Core math word problems',
            about: 'Math',
            keywords: 'Shooloo, common core, CCSS, math, word problem, critique, rate, real life, cooperative learning',
            dateCreated: '03-01-2013',
            timeRequired: 'PT0H5M', 
            author: 'students',
            publisher: 'Shooloo Inc.',
            inLanguage: 'EN_US',
            typicalAgeRange: ['8-10', '10-12', '12-14'],
            interactivityType: 'Mixed',
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

  def about
    set_meta_tags title: 'About Us', 
        description: 'Shooloo company description', 
        keywords: %w[Shooloo about description]
  end

  def team
    set_meta_tags title: 'Team', 
        description: 'Shooloo team members', 
        keywords: %w[Shooloo team]
  end

  def advisors
    set_meta_tags title: 'Advisors', 
        description: 'Shooloo advisors', 
        keywords: %w[Shooloo advisors]
  end

  def privacy
    set_meta_tags title: 'Privacy Statement', 
        description: 'Shooloo privacy statement', 
        keywords: %w[Shooloo privacy]
  end

  def rules
    set_meta_tags title: 'Rules of Conduct', 
        description: 'Shooloo rules of conduct', 
        keywords: %w[Shooloo rules conduct]
  end

  def terms
    set_meta_tags title: 'Terms of Use', 
        description: 'Shooloo terms of use', 
        keywords: %w[Shooloo terms use]
  end

  def sample_dashboard
  end

  def sample_assignment
  end

  def contest
  end
end
