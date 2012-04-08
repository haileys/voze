class UserMailer < ActionMailer::Base
  default from: AppConfig.mail.from
  
  def password_reset_email(user)
    @user = user
    @url = password_reset_url(user.password_reset_token)
    mail to: user.email, subject: "Password reset for #{AppConfig.site_name}"
  end
  
  def welcome_email(user)
    @user = user
    @url = root_url
    mail to: user.email, subject: "Welcome to #{AppConfig.site_name}"
  end
end
