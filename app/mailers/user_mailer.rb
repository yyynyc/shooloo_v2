class UserMailer < ActionMailer::Base
  default from: "support@shooloo.org"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
    @user = user
    mail to: user.personal_email, subject: "Shooloo Password Reset"
  end

  def parental_consent(user)
    @user = user
    mail to: user.parent_email, 
        subject: "Confirm Your Child's Membership of Shooloo (a math program)"
  end

  def activity_alert(user)
    @user = user
    unless Activity.where(read: nil, recipient_id: @user.id).blank? 
      mail to: user.personal_email, 
        subject: "Your Activity Alerts From Shooloo"
    end
  end
end
