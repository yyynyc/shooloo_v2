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

  def signup_confirmation(user)
    @user = user
    mail to: user.personal_email, subject: "Sign Up Confirmation"
  end
end
