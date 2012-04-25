class AnnouncesController < ApplicationController
  def announce
    authorize! :announce, :announces
    
    @torrent = Torrent.find_by_info_hash! to_hex(params[:info_hash] || "")
    peer_id = to_hex params[:peer_id]
    args = { ip: request.remote_addr }
    args.merge! params.slice(:port, :uploaded, :downloaded, :left, :ip)
    
    @peer = Peer.find_by_peer_id_and_torrent_id(peer_id, @torrent.id) || Peer.new(torrent: @torrent, user: current_user, peer_id: peer_id)
    
    if params[:event] == "stopped"
      @peer.delete
      render nothing: true
    else
      @peer.update_attributes! args    
      render text: {
        "interval"    => 20.minutes,
        "complete"    => @torrent.seeders.count,
        "incomplete"  => @torrent.leechers.count,
        "peers"       => @torrent.optimal_peers.limit(params[:numwant]).map(&:as_tracker_response)
      }.bencode
    end
  end

private
  def to_hex(str)
    str.bytes.map { |x| sprintf "%02X", x }.join
  end
end