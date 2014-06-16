class LessonsController < ApplicationController
  before_filter :signed_in_user
  skip_before_filter :signed_in_user, only: :index
  before_filter :correct_user, only: :destroy
  load_and_authorize_resource
  # respond_to :html, :json

  def new
    @lesson = Lesson.new
  end

  def create
    @user = current_user
    @lesson = @user.lessons.build(params[:lesson])
    if @lesson.save
      flash[:notice] = "Fantastic! You've created your own lesson plan on Shooloo."
      redirect_to lessons_user_path(@user)
    else
      @lessons = []
      render 'new'
    end
  end

  def show 
    @lesson = Lesson.find(params[:id])   
  end

  def edit
    @lesson = current_user.lessons.find_by_id(params[:id])
  end

  def update
     @lesson = current_user.lessons.find_by_id(params[:id]) 
    if     
      @lesson.update_attributes(params[:lesson])
      flash[:success] = "You have upddated your lesson plan successfully!"
      redirect_to lessons_user_path(current_user)
    else
      render 'edit'
    end
  end

  def index
    @search = Lesson.search(params[:q])
    @lessons = @search.result.paginate(page: params[:page], per_page: 40,order: 'created_at DESC')
    @search.build_condition
    if signed_in?
      @like = Like.new
    end
  end

  def comment
    @lesson = Lesson.find(params[:lesson_id])   
    @comment = Comment.new
    @comments = @lesson.comments.order('created_at DESC')
    @like = Like.new
    @liked_lesson = @like.liked_lesson
    @liked_comment = @like.liked_comment
  end

  def comments
    @lesson  = Lesson.find(params[:lesson_id])
    @comment=current_user.comments.build(params[:comment])
    @like = Like.new           
    if @comment.save
        @comment.commented_lesson = @lesson    
        if @lesson.comments_count.nil?
            @lesson.comments_count=0
            @lesson.save!(validate: false)
        end
        @lesson.comments_count +=1
        @lesson.save!(validate: false)     
        @comments = @lesson.comments.order('created_at DESC')      
        redirect_to lesson_comment_path(@lesson)
    else 
        raise "you need a lesson" if @lesson.nil?
        @lesson  = @comment.commented_lesson
        @comments = @lesson.comments.order('created_at DESC')      
        render 'comment'
    end 
  end

  def edit_comment
  end
end
