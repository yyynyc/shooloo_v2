class Contact < ActionMailer::Base
  
  def notification(message)
    @message = message
    mail 	to: "ryang@prosperityprana.com", 
    		from: message.email,
    		subject: "[Shooloo.org] #{message.subject}"
  end
end
