

import UIKit

class MusicSearchScreen: UITableViewController
{
    var tracks: [Track] = [] //FIXME: Be immutable
    let searchEngine: SearchEngine
    let downloadService: DownloadService
    
    init(searchEngine: SearchEngine, downloadService: DownloadService) {
        self.searchEngine = searchEngine
        self.downloadService = downloadService
        super.init(nibName: nil, bundle: nil)
        title = "Music Search"
        navigationItem.searchController = searchEngine
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: TrackCell.id)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: TrackCell.id, for: indexPath)
        let track = tracks[indexPath.row]
        let trackCell = TrackCell(track: track, downloadService: downloadService, files: Files()) //FIXME: Inject Files
        //    trackCell.configure(track: track, downloaded: track.downloaded, download: downloadService.activeDownloads[track.previewURL])  //FIXME: Be Immutable
        embed(viewController: trackCell, inContainerView: cell.contentView)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //FIXME: Push into the cell
        //When user taps cell, play the local file, if it's downloaded.
        //let track = tracks[indexPath.row]
        //if track.downloaded { playDownload(track) } //FIXME: Get the Cell and Tell it to Play
        
        //FIXME: get refference back to cell
        //    let swCell = data.cellForRow(at: indexPath)
        //    swCell.didSelect()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return 81.0 }
}

extension MusicSearchScreen: SearchEngineDelegate {
    func update(tracks: [Track]) {
        self.tracks = tracks
        tableView.reloadData()
        tableView.setContentOffset(CGPoint.zero, animated: false)
    }
}
