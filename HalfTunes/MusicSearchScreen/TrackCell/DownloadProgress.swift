
import UIKit

protocol DownloadProgressDelegate: AnyObject {
    func update() -> Progress
}

class DownloadProgress: UIViewController
{
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var indicator: UIProgressView!   //FIXME: Naming
    weak var delegate: DownloadProgressDelegate?
    var timer: Timer?   //FIXME: Be Immutable
    
    init() {
        super.init(nibName: "DownloadProgress", bundle: nil)
    }
    required init?(coder: NSCoder) { fatalError() }
    
    func startUpdating() {
        self.timer = Timer(timeInterval: 0.10, repeats: true) { _ in
            guard let progress = self.delegate?.update() else { fatalError() }
            guard let eta = progress.estimatedTimeRemaining else { fatalError() }
            self.label.text = eta.string()
            self.indicator.progress = Float(progress.fractionCompleted)
        }
    }
    
    func stopUpdating() { timer?.invalidate() }
    
//    func updateDisplay(progress: Float, totalSize : String) {
//        progressView.progress = progress
//        progressLabel.text = String(format: "%.1f%% of %@", progress * 100, totalSize)
//    }
}

extension TimeInterval
{
    func string() -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional // Use the appropriate positioning for the current locale
        formatter.allowedUnits = [ .hour, .minute, .second ] // Units to display in the formatted string
        formatter.zeroFormattingBehavior = [ .pad ] // Pad with zeroes where appropriate for the locale
        guard let formattedDuration = formatter.string(from: self) else { fatalError() }
        return formattedDuration
    }
}
