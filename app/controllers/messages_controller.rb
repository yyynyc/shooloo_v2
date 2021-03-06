class MessagesController < ApplicationController

  def new
  	@message = Message.new
    set_meta_tags title: 'Contact Us', 
        description: 'Contact form', 
        keywords: %w[Shooloo, contact]
  end

  def create
  	@message = Message.new(params[:message])
    if signed_in?
      if @message.save
        flash[:success] = "Message was sent successfully."
        Contact.notification(@message).deliver
        redirect_to root_path
      else
        render 'new'
      end
    else
    	if verify_recaptcha(@message) && @message.save
    		flash[:success] = "Message was sent successfully."
    		Contact.notification(@message).deliver
    		redirect_to root_path
    	else
    		render 'new'
    	end
    end
  end
end
