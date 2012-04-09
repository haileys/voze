class TorrentsController < ApplicationController
  load_and_authorize_resource
  
  def index
    render
  end
  
  def new
    render
  end
  
  def create
    @torrent = Torrent.new params[:torrent]
    @torrent.expected_announce = personal_announce_url
    @torrent.user = current_user
    if @torrent.save
      redirect_to @torrent
    else
      @errors = @torrent.errors.full_messages
      render "new"
    end
  end
  
  def show
    respond_to do |f|
      f.html    { render }
      f.torrent { render text: @torrent.torrent_file_with(personal_announce_url) }
    end
  end
  
private
  include TorrentsHelper
end
