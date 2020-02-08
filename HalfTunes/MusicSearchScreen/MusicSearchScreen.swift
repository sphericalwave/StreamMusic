
import UIKit
import AVFoundation
import AVKit

class MusicSearchScreen: UITableViewController
{
    var tracks: Tracks? //FIXME: Be immutable
    let searchEngine: SearchEngine
    let channel: URLSession
    
    init(searchEngine: SearchEngine, channel: URLSession) {
        self.searchEngine = searchEngine
        self.channel = channel
        super.init(nibName: nil, bundle: nil)
        title = "Music Search"
        navigationItem.searchController = searchEngine
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: TrackCell.id)
    }
    required init?(coder: NSCoder) { fatalError() }
    
    func playTrack(url: URL) {
        let audioPlayerScreen = AVPlayerViewController() //FIXME: Inject?
        present(audioPlayerScreen, animated: true, completion: nil)
        let player = AVPlayer(url: url)
        audioPlayerScreen.player = player
        player.play()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: TrackCell.id, for: indexPath)
        guard let track = tracks?[indexPath.row] else { fatalError() }
        let download = channel.downloadTask(with: track.previewURL)
        let trackCell = TrackCell(track: track, download: download)
        embed(viewController: trackCell, inContainerView: cell.contentView)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks?.count ?? 0   //FIXME: Not a fan
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let trackUrl = tracks?.urlForTrack(at: indexPath) else { fatalError() }
        playTrack(url: trackUrl)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 99.0
    }
}

extension MusicSearchScreen: SearchEngineDelegate
{
    func update(tracks: Tracks) {
        self.tracks = tracks
        tableView.reloadData()
        tableView.setContentOffset(CGPoint.zero, animated: false)
    }
}
