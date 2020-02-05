
import AVFoundation
import AVKit
import UIKit

class MusicSearchScreen: UITableViewController
{
  /// Get local file path: download task stores tune here; AV player plays it.
  let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
  lazy var downloadsSession: URLSession = { //FIXME: Be Immutable
    let configuration = URLSessionConfiguration.background(withIdentifier:
      "com.raywenderlich.HalfTunes.bgSession")
    return URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
  }()
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
  
  func localFilePath(for url: URL) -> URL {
    return documentsPath.appendingPathComponent(url.lastPathComponent)
  }
  
  func playDownload(_ track: Track) {
    let playerViewController = AVPlayerViewController()
    present(playerViewController, animated: true, completion: nil)
    let url = localFilePath(for: track.previewURL)
    let player = AVPlayer(url: url)
    playerViewController.player = player
    player.play()
  }
  
  func position(for bar: UIBarPositioning) -> UIBarPosition { return .topAttached }
  
  func reload(_ row: Int) {
    tableView.reloadRows(at: [IndexPath(row: row, section: 0)], with: .none)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .blue
    downloadService.downloadsSession = downloadsSession //FIXME: What is this?
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
  {
    let cell = tableView.dequeueReusableCell(withIdentifier: TrackCell.id, for: indexPath)
    let track = tracks[indexPath.row]
    let trackCell = TrackCell(track: track)
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
    let track = tracks[indexPath.row]
    if track.downloaded { playDownload(track) }
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

extension MusicSearchScreen: UISearchResultsUpdating
{
  //FIXME: I don't care for the naming of this method
  //Can i wrap it with a protocol extension?
  func updateSearchResults(for searchController: UISearchController) {
    print("What do i do here")
    //searchController.
  }
}

extension MusicSearchScreen: URLSessionDelegate
{
  func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
    //FIXME: This is awful
    DispatchQueue.main.async {
      if let appDelegate = UIApplication.shared.delegate as? AppDelegate,
        let completionHandler = appDelegate.backgroundSessionCompletionHandler {
        appDelegate.backgroundSessionCompletionHandler = nil
        completionHandler()
      }
    }
  }
}

extension MusicSearchScreen: URLSessionDownloadDelegate
{
  func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask,
                  didFinishDownloadingTo location: URL)
  {
    guard let sourceURL = downloadTask.originalRequest?.url else { return }
    let download = downloadService.activeDownloads[sourceURL]
    downloadService.activeDownloads[sourceURL] = nil
    
    let destinationURL = localFilePath(for: sourceURL)
    print(destinationURL)
    
    let fileManager = FileManager.default
    try? fileManager.removeItem(at: destinationURL)
    
    do {
      try fileManager.copyItem(at: location, to: destinationURL)
      download?.track.downloaded = true
    } catch let error {
      print("Could not copy file to disk: \(error.localizedDescription)")
    }
    
    if let index = download?.track.index {
      DispatchQueue.main.async { [weak self] in
        self?.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
      }
    }
  }
  
  func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask,
                  didWriteData bytesWritten: Int64, totalBytesWritten: Int64,
                  totalBytesExpectedToWrite: Int64) {
//    guard
//      let url = downloadTask.originalRequest?.url,
//      let download = downloadService.activeDownloads[url]  else {
//        return
//    }
//
//    download.progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
//    let totalSize = ByteCountFormatter.string(fromByteCount: totalBytesExpectedToWrite, countStyle: .file)
//
//    DispatchQueue.main.async {
////      if let trackCell = self.tableView.cellForRow(at: IndexPath(row: download.track.index,
////                                                                 section: 0)) as? TrackCell {
////        trackCell.updateDisplay(progress: download.progress, totalSize: totalSize)
////      }
//    }
  }
}
