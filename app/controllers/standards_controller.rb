class StandardsController < ApplicationController
	respond_to :html, :json

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

	def edit
		@standard = Standard.find(params[:id])
	end

	def update
		if signed_in? && current_user.admin?
			@standard = Standard.find(params[:id])
			respond_to do |format|
			    if @standard.update_attributes(params[:standard])
			      format.html { redirect_to(@standard, :notice => 'Standard was successfully updated.') }
			      format.json { respond_with_bip(@standard) }
			    else
			      format.html { render :action => "edit" }
			      format.json { respond_with_bip(@standard) }
			    end
			end
		end
	end
end
