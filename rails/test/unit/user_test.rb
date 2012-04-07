require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "gravatar of a user is correct" do
    assert_equal "http://www.gravatar.com/avatar/bc6a715808d9aae0ddeefb1e47e482a6", User.make(email: "john@doe.org").gravatar_url
  end
end
