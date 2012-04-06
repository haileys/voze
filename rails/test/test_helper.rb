ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require File.expand_path(File.dirname(__FILE__) + '/blueprints')
require 'rails/test_help'

class ActiveSupport::TestCase
  fixtures :all
  
  def login(user = {})
    user = User.make! user if user.is_a? Hash
    @controller.session[:user_id] = user.id
  end
end
