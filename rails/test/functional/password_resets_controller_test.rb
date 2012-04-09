require 'test_helper'

class PasswordResetsControllerTest < ActionController::TestCase
  test "can reset password if logged out" do
    get :new
    assert_response :success
  end
  
  test "password reset acts successful even if an invalid username is used" do
    post :create, password_reset: { username: "nope" }
    assert_response :success
    assert response.body.include? "has been emailed to you"
  end
  
  test "password reset works with a username" do
    user = User.make!
    refute user.password_reset_token
    post :create, password_reset: { username: user.username }
    assert user.reload.password_reset_token
  end
  
  test "password reset works with an email" do
    user = User.make!
    refute user.password_reset_token
    post :create, password_reset: { username: user.email }
    assert user.reload.password_reset_token
  end
  
  test "password reset emails the user a reset token" do
    user = User.make!
    assert_difference "ActionMailer::Base.deliveries.count" do
      post :create, password_reset: { username: user.username }
    end
    assert ActionMailer::Base.deliveries.last.encoded.include? user.reload.password_reset_token
  end
  
  test "a successful password reset logs the user in and redirects" do
    user = User.make!
    user.generate_password_reset_token!
    get :show, id: user.password_reset_token
    assert_response :redirect
    assert_equal user, @controller.current_user
  end
end
