class MessagesController < ApplicationController

  def new
  	@message = Message.new
  end

  def create
  	@message = Message.new(params[:message])
  	if @message.save
  		flash[:success] = "Message was sent successfully."
  		Contact.notification(@message).deliver
  		redirect_to root_path
  	else
  		flash.now[:error] = "Sorry, required field or secret code is not valid!"
  		render 'new'
  	end
  end
end
