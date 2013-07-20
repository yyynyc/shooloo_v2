class UserMailer < ActionMailer::Base
  include SendGrid
  sendgrid_enable :ganalytics, :opentrack, :clicktrack, :sbuscriptiontrack, :spamcheck

  default from: "Shooloo@fun.shooloo.org"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
    sendgrid_category "password reset"
    @user = user
    mail to: user.personal_email, subject: "Shooloo Password Reset"
  end

  def parental_consent(user)
    sendgrid_category "parental consent"
    @user = user
    mail to: user.parent_email, 
        subject: "Confirm Your Child's Membership of Shooloo (a math program)"
  end

  def activity_alert(user)
    sendgrid_category "activity alerts"
    @user = user
    unless @user.personal_email.blank? || 
        Activity.where(read: nil, recipient_id: @user.id).blank? 
      mail to: user.personal_email, 
        subject: "#{user.first_name}: Your Activity Alerts From Shooloo"
    end
  end
end
