class HomeController < ApplicationController
  skip_authorization_check
  
  def index
    authorize! :index, :home
  end
end
