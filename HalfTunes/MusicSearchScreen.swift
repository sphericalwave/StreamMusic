
import AVFoundation
import AVKit
import UIKit

class MusicSearchScreen: UIViewController
{
  /// Get local file path: download task stores tune here; AV player plays it.
  let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
  let downloadService = DownloadService()
  let queryService = QueryService()
  @IBOutlet weak var tableView: UITableView!
  lazy var downloadsSession: URLSession = { //FIXME: Be Immutable
    let configuration = URLSessionConfiguration.background(withIdentifier:
      "com.raywenderlich.HalfTunes.bgSession")
    return URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
  }()
  var searchResults: [Track] = [] //FIXME: Be immutable
  let searchEngine: SearchEngine
  
  init(searchEngine: SearchEngine) {
    self.searchEngine = searchEngine
    super.init(nibName: nil, bundle: nil)
    title = "Music Search"
    navigationItem.searchController = searchEngine
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
}

extension MusicSearchScreen: UITableViewDataSource {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
  {
    let cell = tableView.dequeueReusableCell(withIdentifier: "wtvr", for: indexPath)
    let trackCell = TrackCell()
    let track = searchResults[indexPath.row]
    trackCell.configure(track: track, downloaded: track.downloaded, download: downloadService.activeDownloads[track.previewURL])  //FIXME: Be Immutable
    embed(viewController: trackCell, inContainerView: cell.contentView)
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return searchResults.count }
}

extension MusicSearchScreen: UITableViewDelegate
{
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //When user taps cell, play the local file, if it's downloaded.
    
    let track = searchResults[indexPath.row]
    
    if track.downloaded {
      playDownload(track)
    }
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return 69.0 }
}

extension MusicSearchScreen: URLSessionDelegate
{
  func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
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
