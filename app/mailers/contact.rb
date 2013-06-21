class Contact < ActionMailer::Base
  default from: "Shooloo@fun.shooloo.org"

  def notification(message)
    @message = message
    mail 	to: "ryang@prosperityprana.com", 
    		subject: "[Shooloo.org] #{message.subject}"
  end
end
