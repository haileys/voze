require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test "can fetch homepage" do
    get :index
    assert_response :success
  end
end
