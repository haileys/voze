require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "password reset email contains url for user to reset their password" do
    user = User.make
    user.generate_password_reset_token!
    email = UserMailer.password_reset_email(user).deliver
    refute ActionMailer::Base.deliveries.empty?
    assert_equal [user.email], email.to
    assert email.encoded.include? user.password_reset_token
  end
end
