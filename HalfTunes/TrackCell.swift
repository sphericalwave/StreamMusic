
import UIKit

protocol TrackCellDelegate
{
  func cancelTapped(_ cell: TrackCell)
  func downloadTapped(_ cell: TrackCell)
  func pauseTapped(_ cell: TrackCell)
  func resumeTapped(_ cell: TrackCell)
}

class TrackCell: UIViewController
{
  static let identifier = "TrackCell"
  //FIXME: Break Into Smaller Objects
  @IBOutlet weak var artistLabel: UILabel!
  @IBOutlet weak var cancelButton: UIButton!
  @IBOutlet weak var downloadButton: UIButton!
  @IBOutlet weak var pauseButton: UIButton!
  @IBOutlet weak var progressLabel: UILabel!
  @IBOutlet weak var progressView: UIProgressView!
  @IBOutlet weak var titleLabel: UILabel!
  
  var delegate: TrackCellDelegate?
  
  @IBAction func cancelTapped(_ sender: AnyObject) {
    delegate?.cancelTapped(self)
  }
  
  @IBAction func downloadTapped(_ sender: AnyObject) {
    delegate?.downloadTapped(self)
  }
  
  @IBAction func pauseOrResumeTapped(_ sender: AnyObject) {
    if(pauseButton.titleLabel?.text == "Pause") {
      delegate?.pauseTapped(self)
    } else {
      delegate?.resumeTapped(self)
    }
  }
  
  func configure(track: Track, downloaded: Bool, download: Download?) {
    titleLabel.text = track.name
    artistLabel.text = track.artist
    
    // Show/hide download controls Pause/Resume, Cancel buttons, progress info.
    var showDownloadControls = false
    
    // Non-nil Download object means a download is in progress.
    if let download = download {
      showDownloadControls = true
      
      let title = download.isDownloading ? "Pause" : "Resume"
      pauseButton.setTitle(title, for: .normal)
      
      progressLabel.text = download.isDownloading ? "Downloading..." : "Paused"
    }
    
    pauseButton.isHidden = !showDownloadControls
    cancelButton.isHidden = !showDownloadControls
    
    progressView.isHidden = !showDownloadControls
    progressLabel.isHidden = !showDownloadControls
    
    // If the track is already downloaded, enable cell selection and hide the Download button.
    //selectionStyle = downloaded ? UITableViewCell.SelectionStyle.gray : UITableViewCell.SelectionStyle.none
    downloadButton.isHidden = downloaded || showDownloadControls
  }
  
  func updateDisplay(progress: Float, totalSize : String) {
    progressView.progress = progress
    progressLabel.text = String(format: "%.1f%% of %@", progress * 100, totalSize)
  }
}

//FIXME: Setup Playback
//extension MusicSearchScreen: TrackCellDelegate
//{
//  func cancelTapped(_ cell: TrackCell) {
////    if let indexPath = tableView.indexPath(for: cell) {
////      let track = searchResults[indexPath.row]
////      downloadService.cancelDownload(track)
////      reload(indexPath.row)
////    }
//  }
//
//  func downloadTapped(_ cell: TrackCell) {
////    if let indexPath = tableView.indexPath(for: cell) {
////      let track = searchResults[indexPath.row]
////      downloadService.startDownload(track)
////      reload(indexPath.row)
////    }
//  }
//
//  func pauseTapped(_ cell: TrackCell) {
////    if let indexPath = tableView.indexPath(for: cell) {
////      let track = searchResults[indexPath.row]
////      downloadService.pauseDownload(track)
////      reload(indexPath.row)
////    }
//  }
//
//  func resumeTapped(_ cell: TrackCell) {
////    if let indexPath = tableView.indexPath(for: cell) {
////      let track = searchResults[indexPath.row]
////      downloadService.resumeDownload(track)
////      reload(indexPath.row)
////    }
//  }
//}
