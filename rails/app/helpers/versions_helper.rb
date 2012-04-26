module VersionsHelper
  def personal_announce_url
    announce_url auth_token: current_user.auth_token
  end

  def render_metadata(section)
    partial_name = "#{@torrent.metadata.class.name.underscore}/#{section}"
    render partial: partial_name, locals: { metadata: @torrent.metadata }
  end
end
