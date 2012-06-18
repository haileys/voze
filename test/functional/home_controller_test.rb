require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test "can't fetch homepage when not logged in" do
    get :index
    assert_redirected_to_login
  end
  
  test "can fetch homepage when logged in" do
    login
    get :index
    assert_response :success
  end
end
