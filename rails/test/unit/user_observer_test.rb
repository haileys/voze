require 'test_helper'

class WelcomeUserObserverObserverTest < ActiveSupport::TestCase
  test "user is sent welcome email after registration" do
    assert_difference "ActionMailer::Base.deliveries.count" do
      user = User.make!
    end
  end
end
