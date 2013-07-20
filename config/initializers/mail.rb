#ActionMailer::Base.smtp_settings = {
#  :openssl_verify_mode  => 'none' #if using wildcard and/or self-signed ssl certificates for mail server
#}
#route emails to SendGrid server
ActionMailer::Base.smtp_settings =  {
    user_name: 'shooloo',
    password: 'mathfun2013',
    domain: 'fun.shooloo.org', 
    address: 'smtp.sendgrid.net', 
    port: 587,
    authentication: :plain,
    enable_starttls_auto: true,
  }
