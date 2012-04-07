require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "gravatar of a user is correct" do
    assert_equal "http://www.gravatar.com/avatar/bc6a715808d9aae0ddeefb1e47e482a6", User.make(email: "john@doe.org").gravatar_url
  end
  
  test "old invite cannot be reused" do
    old_user = User.make!
    new_user = User.make
    new_user.invite_code = old_user.invite_code
    refute new_user.save
    assert new_user.errors[:invite_code]
  end
end
