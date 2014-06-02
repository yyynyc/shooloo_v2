class PostsController < ApplicationController
	before_filter :signed_in_user
  skip_before_filter :signed_in_user, only: :index
  before_filter :correct_user, only: [:destroy, :draft, :entry]
  load_and_authorize_resource
  
  def index
    @search = Post.where(state: ["verified", "published", "old", "revised"]).search(params[:q])
    @posts = @search.result.paginate(page: params[:page], 
        per_page: 20, order: 'state DESC, created_at DESC')
    @search.build_condition
    if signed_in?
      @like = current_user.likes.build(params[:like])
    end
    @levels = Level.all
    @domains = Domain.all
    @standards = Standard.all
    set_meta_tags title: 'Common Core Math Word Problems',                       
            keywords: 'Shooloo, common core, CCSS, math, word problem, critique, rate, real life, cooperative learning'
  end

  def show
    index
    render :action => 'index'
    set_meta_tags title: 'Common Core Math Word Problems', 
            description: 'Index of all Common Core math word problems published on Shooloo',
            keywords: 'Shooloo, Common Core, CCSS, math, word problem, critique, rate, real life, cooperative learning'
  end

  def post_master
    @posts = Post.all
    @qualified = Post.where(qualified: "yes").order('created_at DESC')
    @drafts = Post.where(state: "draft").order('created_at DESC').keep_if{|p| p.alarm.nil?}
    @alarmed = Post.order('created_at DESC').keep_if{|p| !p.alarms.blank?}
    @submissions = Post.where(state: "submitted").order('created_at DESC')
    @checked_out = Post.where(state: "under_review").order('created_at DESC')
    @verified = Post.where(state: "verified").order('created_at DESC')
    @revised = Post.where(state: "revised").order('created_at DESC')
    @published = Post.where(state: "published").order('created_at DESC')
    @old = Post.where(state: "old").order('created_at DESC')
  end

  def new  
    if params.has_key?(:response_id)  
      @response = Response.find(params[:response_id])
      if current_user == @response.assignee || current_user.admin?
        @post = @response.posts.build(params[:post])
        @assignment = @response.assignment
      else 
        redirect_to root_path
      end
    else
      @post = Post.new
    end
  end

  def create
  	@post = current_user.posts.build(params[:post])      
    @post.save
    render 'draft'
  end

  def draft
    @post = Post.find(params[:post_id])
    @alarm = Alarm.find_by_alarmed_post_id(params[:post_id])
  end

  def corrected
    @post = Post.find(params[:post_id])
    if !@post.correction.nil?
      @correction = @post.correction
    end
  end

  def edit
    if current_user.admin? 
      @post = Post.find(params[:id])
    else
      @post = current_user.posts.find_by_id(params[:id])
    end    
    set_meta_tags title: 'Edit Common Core Math Word Problem #'+ @post.id.to_s, 
            description: 'Shooloo member edit Common Core math 
                problem #' + @post.id.to_s,            
            keywords: 'Shooloo, common core, CCSS, math, word problem, edit, real life, review'
  end

  def update
    if current_user.admin? 
      @post = Post.find(params[:id])
    else
      @post = current_user.posts.find_by_id(params[:id])
    end 
    @post.update_attributes(params[:post])
    if params[:button] == "save"
      @post.save
      render 'draft'
    elsif params[:button] == "submit"
      if @post.submit
        sign_in current_user
        flash[:success] = "Submitted! You will get an alert when your post is approved for publication. #{ActionController::Base.helpers.link_to "Check your points", gift_receiving_path} from Shooloo.".html_safe
        redirect_to root_path
      else      
        render 'edit'
      end
    elsif params[:button] == "publish"
      if @post.publish
        sign_in current_user
        flash[:notice] = "Success! #{ActionController::Base.helpers.link_to "Check your points", gift_receiving_path} from Shooloo.".html_safe
        redirect_to root_path
      else      
        render 'edit'
      end
    elsif params[:button] == "revision"
      if @post.revise
        sign_in current_user
        flash[:notice] = "success!"
        redirect_to post_comments_path(@post)
      else      
        render 'edit'
      end
    end    
  end

  def destroy
    @post.destroy
    current_user.post_count -= 1
    current_user.save
    sign_in current_user
    flash[:error] = "Sorry, you've just #{ActionController::Base.helpers.link_to "lost some points", gift_receiving_path} from Shooloo.".html_safe
    redirect_to root_url
  end

  def teacher_view
    @post  = Post.find(params[:post_id])
    @comments = @post.comments.visible.order('created_at DESC')
    @alarm = Alarm.new
    @rating = Rating.new
    @like = Like.new
    @liked_post = @like.liked_post
    @liked_comment = @like.liked_comment
    @comment=current_user.comments.build(params[:comment])
    @comment.commented_post=@post  
  end

  def correct_user
    @post  = Post.find(params[:post_id])
    unless current_user == @post.user || current_user.admin? || current_user.in?(@post.user.authorizers)
      flash[:error] = "You don't have access to this draft."
      redirect_to root_url 
    end
  end
end
