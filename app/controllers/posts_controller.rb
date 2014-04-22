class PostsController < ApplicationController
	before_filter :signed_in_user
  skip_before_filter :signed_in_user, only: :index
  before_filter :correct_user, only: [:destroy, :draft, :entry]
  load_and_authorize_resource
  
  def index
    @search = Post.visible.search(params[:q])
    if signed_in? 
      @posts = @search.result.visible.paginate(page: params[:page], 
          per_page: 20, order: 'created_at DESC')
    else
       @posts = @search.result.visible.paginate(page: params[:page], 
        per_page: 20, order: 'comments_count DESC, likes_count DESC, created_at DESC')
    end
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
    @post = current_user.posts.find_by_id(params[:post_id])
    # @post = Post.find(params[:id])
  end

  def edit
    if current_user.admin? || current_user.role == "teacher"
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
    if current_user.admin? || current_user.role == "teacher"
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
        @post.likes_count = 0
        @post.comments_count = 0
        @post.ratings_count = 0
        if current_user.post_count.nil?
          current_user.post_count = 0
        end
        current_user.post_count += 1
        current_user.save
        sign_in current_user
        flash[:notice] = "Fantastic! #{ActionController::Base.helpers.link_to "Check your points", gift_receiving_path} from Shooloo and your progress in your #{ActionController::Base.helpers.link_to "I-Can Journal", common_core_I_can_user_path(current_user)}.".html_safe
        redirect_to post_comments_path(@post)
      else      
        render 'edit'
      end
    end
  end

  def entry
    @post = current_user.posts.find_by_id(params[:post_id])
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
      @post = current_user.posts.find_by_id(params[:post_id])
      redirect_to root_url if @post.nil?
  end
end
