module VersionsHelper
  def render_metadata(section)
    partial_name = "#{@torrent.metadata.class.name.underscore}/#{section}"
    render partial: partial_name, locals: { metadata: @torrent.metadata }
  end
end
