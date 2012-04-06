ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require File.expand_path(File.dirname(__FILE__) + '/blueprints')
require 'rails/test_help'
require 'authlogic/test_case'

class ActiveSupport::TestCase
  fixtures :all
  setup :activate_authlogic
  
  def login(opts = {})
    UserSession.create User.make!(opts)
  end
end
