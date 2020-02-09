
import UIKit

class TrackCell: UIViewController
{
    static let id = "TrackCell" //FIXME: Framework violating OOP
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressContainer: UIView!
    @IBOutlet weak var buttonContainer: UIView!
    let track: Track2
    let downloadProgress: DownloadProgress
    let download: URLSessionDownloadTask
    
    init(track: Track2, download: URLSessionDownloadTask) {
        self.track = track
        self.download = download
        self.downloadProgress = DownloadProgress()
        super.init(nibName: "TrackCell2", bundle: nil)
        downloadProgress.delegate = self
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = track.name
        artistLabel.text = track.artist

        let downloadButtons = DownloadButtons()
        downloadButtons.delegate = self
        embed(viewController: downloadButtons, inContainerView: buttonContainer)

        embed(viewController: downloadProgress, inContainerView: progressContainer)
    }
}

extension TrackCell: DownloadButtonsDelegate
{
    func download2() {
        download.resume()
        downloadProgress.startUpdating()    //FIXME: Duplication Here ∆
    }
    
    func pause() {
        download.cancel()
        downloadProgress.stopUpdating()
    }
    
    func resume() {
        download.resume()
        downloadProgress.startUpdating()
    }
    
    func cancel() {
        download.cancel()
        downloadProgress.stopUpdating()
    }
}

extension TrackCell: DownloadProgressDelegate
{
    func update() -> Progress {
        return download.progress
    }
}
