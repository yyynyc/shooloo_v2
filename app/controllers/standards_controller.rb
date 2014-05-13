class StandardsController < ApplicationController
	before_filter :correct_user, only: [:new, :create, :edit, :update]
	
	def index
		set_meta_tags title: 'Common Core Math Standards, I-Can Statements, Lesson Plans, and Video Tutorials'
	end

	def practice
		@practices = Practice.all
		set_meta_tags title: 'Common Core Math Practices, Lesson Plans, and Video Tutorials'
		render 'practice'
	end

	def grade_k	
		@domains = Domain.where(level_id: 1)
		set_meta_tags title: 'Kindergarten Common Core Math Standards, I-Can Statements, Lesson Plans, and Video Tutorials'
		render 'grade_k'
	end

	def grade_1	
		@domains = Domain.where(level_id: 2)
		set_meta_tags title: '1st-Grade Common Core Math Standards, I-Can Statements, Lesson Plans, and Video Tutorials'
		render 'grade_1'
	end

	def grade_2	
		@domains = Domain.where(level_id: 3)
		set_meta_tags title: '2nd-Grade Common Core Math Standards, I-Can Statements, Lesson Plans, and Video Tutorials'
		render 'grade_2'
	end

	def grade_3	
		@domains = Domain.where(level_id: 4)
		set_meta_tags title: '3rd-Grade Common Core Math Standards, I-Can Statements, Lesson Plans, and Video Tutorials'
		render 'grade_3'
	end

	def grade_4	
		@domains = Domain.where(level_id: 5)
		set_meta_tags title: '4th-Grade Common Core Math Standards, I-Can Statements, Lesson Plans, and Video Tutorials'
		render 'grade_4'
	end

	def grade_5	
		@domains = Domain.where(level_id: 6)
		set_meta_tags title: '5th-Grade Common Core Math Standards, I-Can Statements, Lesson Plans, and Video Tutorials'
		render 'grade_5'
	end

	def grade_6	
		@domains = Domain.where(level_id: 7)
		set_meta_tags title: '6th-Grade Common Core Math Standards, I-Can Statements, Lesson Plans, and Video Tutorials'
		render 'grade_6'
	end

	def grade_7	
		@domains = Domain.where(level_id: 8)
		set_meta_tags title: '7th-Grade Common Core Math Standards, I-Can Statements, Lesson Plans, and Video Tutorials'
		render 'grade_7'
	end

	def grade_8	
		@domains = Domain.where(level_id: 9)
		set_meta_tags title: '8th-Grade Common Core Math Standards, I-Can Statements, Lesson Plans, and Video Tutorials'
		render 'grade_8'
	end

	def hs_algebra	
		@standards = Standard.where(domain_id: 44)
		set_meta_tags title: 'Common Core High School Algebra Standards, I-Can Statements, Lesson Plans, and Video Tutorials'
		render 'hs_algebra'
	end

	def hs_modeling	
		@standards = Standard.where(domain_id: 45)
		set_meta_tags title: 'Common Core High School Modeling Standards, I-Can Statements, Lesson Plans, and Video Tutorials'
		render 'hs_modeling'
	end

	def hs_geometry	
		@standards = Standard.where(domain_id: 46)
		set_meta_tags title: 'Common Core High School Geometry Standards, I-Can Statements, Lesson Plans, and Video Tutorials'
		render 'hs_geometry'
	end

	def hs_stats	
		@standards = Standard.where(domain_id: 47)
		set_meta_tags title: 'Common Core High School Statistics & Probabilities Standards, I-Can Statements, Lesson Plans, and Video Tutorials'
		render 'hs_stats'
	end

	def hs_functions	
		@standards = Standard.where(domain_id: 48)
		set_meta_tags title: 'Common Core High School Functions Standards, I-Can Statements, Lesson Plans, and Video Tutorials'
		render 'hs_functions'
	end

	def hs_number	
		@standards = Standard.where(domain_id: 49)
		set_meta_tags title: 'Common Core High School Functions Standards, I-Can Statements, Lesson Plans, and Video Tutorials'
		render 'hs_number'
	end

	def new
		@standard = Standard.new
	end

	def create
		@standard = Standard.new(params[:standard])
		if @standard.save
			flash[:success] = "Success!"
  			redirect_to levels_path
		else
			render 'new'
		end
	end

	def show
		@standard = Standard.find(params[:id])
	    if @standard.id - 1 == 0
	      @previous = @standard
	    else
	      @previous = Standard.find(@standard.id-1)
	    end
	    @next = Standard.find(@standard.id+1)
	end

	def edit
		@standard = Standard.find(params[:id])
	end

	def update
		@standard = Standard.find(params[:id])
		if @standard.update_attributes(params[:standard])
			flash[:success] = "Success!"
  			redirect_to levels_path
		else
			render 'edit'
		end
	end

	def correct_user
	    unless signed_in? && current_user.admin? 
	      flash[:error] = "You don't have access to this page."
	      redirect_to root_url 
	    end
	end
end
