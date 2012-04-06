class ApplicationController < ActionController::Base
  protect_from_forgery

protected
  include ApplicationHelper
end
