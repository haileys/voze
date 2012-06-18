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
  
  test "can't create new user when logged in" do
    login
    assert_no_difference "User.count" do
      post :create, user: User.make.attributes.slice(:username, :password, :password_confirmation, :email, :invite_code)
      assert_response :forbidden
    end
  end
  
  test "registration page can be prefilled with invite code" do
    get :new, invite_code: "dfg45s2df57gs2df5g"
    assert_select "#user_invite_code[value=dfg45s2df57gs2df5g]"
  end
  
  test "can show registration page when not logged in" do
    get :new
    assert_response :success
  end
  
  test "can't register without a valid invite code" do
    assert_no_difference "User.count" do
      post :create, user: User.make.attributes.slice(:username, :password, :password_confirmation, :email)
      assert_select ".errors"
    end
  end
end
