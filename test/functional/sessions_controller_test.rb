require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test "can visit when logged out" do
    get :new
    assert_response :success
  end
  
  test "can't visit when logged in" do
    login
    get :new
    assert_response :forbidden
  end
  
  test "can log in with correct credentials" do
    user = User.make! password: "password", password_confirmation: "password"
    post :create, session: { username: user.username, password: "password" }
    assert_response :redirect
    assert_equal user, @controller.current_user
  end
  
  test "can't log in with incorrect credentials" do
    user = User.make! password: "not lol", password_confirmation: "not lol"
    post :create, session: { username: user.username, password: "lol" }
    refute @controller.current_user
  end
end
