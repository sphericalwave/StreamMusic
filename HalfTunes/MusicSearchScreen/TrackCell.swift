
import UIKit

class TrackCell: UIViewController
{
    static let id = "TrackCell" //FIXME: Framework violating OOP
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var downloadButton: UIButton!    //FIXME: Break Into Component Objects
    @IBOutlet weak var pauseButton: UIButton!
    
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    let track: Track2
    
    init(track: Track2) {
        self.track = track
        super.init(nibName: "TrackCell", bundle: nil)
    }
    required init?(coder: NSCoder) { fatalError() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    @IBAction func cancelTapped() {
        //track.cancelDownload()
        //pauseButton.setTitle("Resume", for: .normal)
        downloadButton.isHidden = false
        pauseButton.isHidden = true
        cancelButton.isHidden = false
    }
    
    @IBAction func downloadTapped() {
        //track.startDownload()
        downloadButton.isHidden = true
        pauseButton.isHidden = false
        cancelButton.isHidden = false
    }
    
    @IBAction func pauseOrResumeTapped() {
        //FIXME: Toggle Behavior Belongs inside a decorated UIButton
        //if ()
        guard let play = UIImage(systemName: "play.circle") else { fatalError() }
        pauseButton.setImage(play, for: .normal)
            //track.pauseDownload()
        //}
        //else {
           //track.resumeDownload()
        //}
    }
    
    //FIXME: This is too big
    func updateUI() {
        titleLabel.text = track.name
        artistLabel.text = track.artist
        downloadButton.isHidden = false
        pauseButton.isHidden = true
        cancelButton.isHidden = true
        progressView.progress = 0.3

        //if track.download.state == .completed
            //show a full progress bar
            //show delete button, hide pause, download & cancel buttons
        
        //if track.state = .running
        
        //if track.state = .suspended
        
        //if track.state = .canceling
        
        //            pauseButton.setTitle(title, for: .normal)
    }
    
    func updateDisplay(progress: Float, totalSize : String) {
        progressView.progress = progress
        progressLabel.text = String(format: "%.1f%% of %@", progress * 100, totalSize)
    }
}
