class VersionsController < ApplicationController
  load_and_authorize_resource :version
  load_and_authorize_resource :torrent
  
  def show
    render
  end

private
  include VersionsHelper
end
