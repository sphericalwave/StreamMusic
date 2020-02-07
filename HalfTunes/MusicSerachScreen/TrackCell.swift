
import UIKit

class TrackCell: UIViewController
{
    static let id = "TrackCell" //FIXME: Framework violating OOP
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var downloadButton: UIButton!    //FIXME: Break Into Component Objects
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    let track: Track
    let downloadedTracks: LocalTracks   //FIXME: matching naming to type
    let files: Files
    
    init(track: Track, downloadedTracks: LocalTracks, files: Files) {
        self.track = track
        self.downloadedTracks = downloadedTracks
        self.files = files  //FIXME: Naming is questionable
        super.init(nibName: "TrackCell", bundle: nil)
    }
    required init?(coder: NSCoder) { fatalError() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure(track: track, downloaded: false, download: nil) //FIXME:
    }
    
    @IBAction func cancelTapped() { downloadedTracks.cancelDownload(track) }
    
    @IBAction func downloadTapped() { downloadedTracks.startDownload(track) }
    
    @IBAction func pauseOrResumeTapped() {
        if (pauseButton.titleLabel?.text == "Pause") { downloadedTracks.pauseDownload(track) }
        else { downloadedTracks.resumeDownload(track) }
    }
    
    //FIXME: This is too big
    func configure(track: Track, downloaded: Bool, download: Download?) {
        titleLabel.text = track.name
        artistLabel.text = track.artist
//        var showDownloadControls = false      // Show/hide download controls Pause/Resume, Cancel buttons, progress info.
//
//        // Non-nil Download object means a download is in progress.
//        if let download = download {
//            showDownloadControls = true
//            let state = download.state()
//            if ( state == .running ) {
//                let title = download.isDownloading ? "Pause" : "Resume"
//            }
//            //let title = download.isDownloading ? "Pause" : "Resume"
//            pauseButton.setTitle(title, for: .normal)
//            progressLabel.text = download.isDownloading ? "Downloading..." : "Paused"
//        }
//        pauseButton.isHidden = !showDownloadControls
//        cancelButton.isHidden = !showDownloadControls
//        progressView.isHidden = !showDownloadControls
//        progressLabel.isHidden = !showDownloadControls
//
//        // If the track is already downloaded, enable cell selection and hide the Download button.
//        //selectionStyle = downloaded ? UITableViewCell.SelectionStyle.gray : UITableViewCell.SelectionStyle.none
//        downloadButton.isHidden = downloaded || showDownloadControls
    }
    
    func updateDisplay(progress: Float, totalSize : String) {
        progressView.progress = progress
        progressLabel.text = String(format: "%.1f%% of %@", progress * 100, totalSize)
    }
}
