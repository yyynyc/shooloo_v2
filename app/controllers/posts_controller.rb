class PostsController < ApplicationController
	before_filter :signed_in_user
  skip_before_filter :signed_in_user, only: :index
  before_filter :correct_user, only: :destroy
  load_and_authorize_resource
  
  def index
    @search = Post.visible.search(params[:q])
    @posts = @search.result.visible.paginate(page: params[:page], per_page: 30, order: 'updated_at DESC')
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
            keywords: 'Shooloo, common core, CCSS, math, word problem, critique, rate, real life, cooperative learning'
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
