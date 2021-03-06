require 'will_paginate/array'

class ChoicesController < ApplicationController

	before_filter :signed_in_user 
	
	def index
		@choice = Choice.new
		@choices = Choice.all.paginate(page: params[:page], order: 'updated_at DESC')
		set_meta_tags title: 'Gift Choices', 
        description: 'Shooloo admin adds new gift choices', 
        noindex: true,
        nofollow: true
	end

	def create
		if current_user.admin?
			@choice = current_user.choices.build(params[:choice])
		    if @choice.save
		      flash[:success] = "Success!"
		      redirect_to choices_path
		    else
		      @choices = []
		      render 'choices/index'
		    end
		end
	end
end