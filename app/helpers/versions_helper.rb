module VersionsHelper
  def render_metadata(section)
    if @torrent.metadata
      partial_name = "#{@torrent.metadata.class.name.underscore}/#{section}"
      render partial: partial_name, locals: { metadata: @torrent.metadata }
    end
  end
end
