class MessagesController < ApplicationController

  def new
  	@message = Message.new
  end

  def create
  	@message = Message.new(params[:message])
  	if verify_recaptcha(@message) && @message.save
  		flash[:success] = "Message was sent successfully."
  		Contact.notification(@message).deliver
  		redirect_to root_path
  	else
  		render 'new'
  	end
  end
end
