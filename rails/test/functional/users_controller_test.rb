require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "cannot view user profile page when not logged in" do
    user = User.make!
    get :show, id: user.username
    assert_redirected_to_login
  end
  
  test "can view user profile page when logged in" do
    login
    user = User.make!
    get :show, id: user.username
    assert response.body.include? user.username
  end
end
