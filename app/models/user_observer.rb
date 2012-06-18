class UserObserver < ActiveRecord::Observer
  def after_create(user)
    # welcome the user to the site:
    UserMailer.welcome_email(user).deliver
  end
end