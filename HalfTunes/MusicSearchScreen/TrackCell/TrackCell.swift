
import UIKit

class TrackCell: UIViewController
{
    static let id = "TrackCell" //FIXME: Framework violating OOP
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var buttonContainer: UIView!
    
    let track: Track2
    //let track: LocalTrack
    let downloadButtons: DownloadButtons
    
    init(track: Track2) {
        self.track = track
        self.downloadButtons = DownloadButtons()
        super.init(nibName: "TrackCell", bundle: nil)
    }
    required init?(coder: NSCoder) { fatalError() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        embed(viewController: downloadButtons, inContainerView: buttonContainer)
    }
    
    //FIXME: This is too big
    func updateUI() {
        titleLabel.text = track.name
        artistLabel.text = track.artist
//        downloadButton.isHidden = false
//        pauseButton.isHidden = true
//        cancelButton.isHidden = true
        progressView.progress = 0.3
    }
    
    func updateDisplay(progress: Float, totalSize : String) {
        progressView.progress = progress
        progressLabel.text = String(format: "%.1f%% of %@", progress * 100, totalSize)
    }
}

extension Files: URLSessionDownloadDelegate   //FIXME: DownloadDelegate
{
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask,
                    didFinishDownloadingTo location: URL)
    {
        //    guard let sourceURL = downloadTask.originalRequest?.url else { return }
        //    let download = downloadService.activeDownloads[sourceURL]
        //    downloadService.activeDownloads[sourceURL] = nil  //removing from active downloads
        //
        //    let path = files.path(for: url)
        //      files.removeFile(at: path)
        //      files.copyFile(at: path)
        //      update the tableViewCell
        
        //    let destinationURL = localFilePath(for: sourceURL)
        //    print(destinationURL)
        //
        //    let fileManager = FileManager.default
        //    try? fileManager.removeItem(at: destinationURL)
        //
        //    do {
        //      try fileManager.copyItem(at: location, to: destinationURL)
        //      download?.track.downloaded = true
        //    } catch let error {
        //      print("Could not copy file to disk: \(error.localizedDescription)")
        //    }
        //
        //    if let index = download?.track.index {
        //      DispatchQueue.main.async { [weak self] in
        //        self?.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
        //      }
        //    }
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



