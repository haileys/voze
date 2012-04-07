class PasswordResetsMailer < ActionMailer::Base
  def reset_email(user)
    @user = user
    @url = password_reset_url(user.password_reset_token)
    mail to: user.email, subject: "Password reset for #{AppConfig.site_name}"
  end
end
