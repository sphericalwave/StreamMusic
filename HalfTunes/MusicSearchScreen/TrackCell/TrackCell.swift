
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
    let downloadButtons: DownloadButtons
    let download: URLSessionDownloadTask
    
    init(track: Track2, download: URLSessionDownloadTask) {
        self.track = track
        self.download = download
        self.downloadButtons = DownloadButtons()
        super.init(nibName: "TrackCell2", bundle: nil)
        
    }
    required init?(coder: NSCoder) { fatalError() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        embed(viewController: downloadButtons, inContainerView: buttonContainer)
    }
    
    func updateUI() {
        titleLabel.text = track.name
        artistLabel.text = track.artist
        progressView.progress = 0.3
    }
    
    func updateDisplay(progress: Float, totalSize : String) {
        progressView.progress = progress
        progressLabel.text = String(format: "%.1f%% of %@", progress * 100, totalSize)
    }
}

extension TrackCell: DownloadButtonsDelegate
{
    func download2() {
        download.resume()
        //start updating  progress
    }
    
    func pause() {
        download.cancel()
        //download.cancel(byProducingResumeData: <#T##(Data?) -> Void#>)
        //stop updating  progress
    }
    
    func resume() {
        download.resume()
        //start updating  progress
    }
    
    func cancel() {
        download.cancel()
        //stop updating  progress
    }
}
