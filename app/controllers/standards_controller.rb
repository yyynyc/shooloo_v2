class StandardsController < ApplicationController
	def index
		set_meta_tags title: 'Common Core Math Standards & I-Can Statements'
	end

	def grade_k	
		@domains = Domain.where(level_id: 1)
		set_meta_tags title: 'Kindergarten Common Core Math Standards & I-Can Statements'
		render 'grade_k'
	end

	def grade_1	
		@domains = Domain.where(level_id: 2)
		set_meta_tags title: '1st-Grade Common Core Math Standards & I-Can Statements'
		render 'grade_1'
	end

	def grade_2	
		@domains = Domain.where(level_id: 3)
		set_meta_tags title: '2nd-Grade Common Core Math Standards & I-Can Statements'
		render 'grade_2'
	end

	def grade_3	
		@domains = Domain.where(level_id: 4)
		set_meta_tags title: '3rd-Grade Common Core Math Standards & I-Can Statements'
		render 'grade_3'
	end

	def grade_4	
		@domains = Domain.where(level_id: 5)
		set_meta_tags title: '4th-Grade Common Core Math Standards & I-Can Statements'
		render 'grade_4'
	end

	def grade_5	
		@domains = Domain.where(level_id: 6)
		set_meta_tags title: '5th-Grade Common Core Math Standards & I-Can Statements'
		render 'grade_5'
	end

	def grade_6	
		@domains = Domain.where(level_id: 7)
		set_meta_tags title: '6th-Grade Common Core Math Standards & I-Can Statements'
		render 'grade_6'
	end

	def grade_7	
		@domains = Domain.where(level_id: 8)
		set_meta_tags title: '7th-Grade Common Core Math Standards & I-Can Statements'
		render 'grade_7'
	end

	def grade_8	
		@domains = Domain.where(level_id: 9)
		set_meta_tags title: '8th-Grade Common Core Math Standards & I-Can Statements'
		render 'grade_8'
	end
end
