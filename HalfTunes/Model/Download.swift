
import Foundation

class Download
{
  var isDownloading = false
  var progress: Float = 0
  var resumeData: Data?
  var task: URLSessionDownloadTask?
  var track: Track
  
  init(track: Track) {
    self.track = track
  }
    
    func start() {
//        download.task = channel.downloadTask(with: track.previewURL)
//        download.task?.resume()
//        download.isDownloading = true
//        activeDownloads[download.track.previewURL] = download
    }
    
    func cancel() {
//        guard let download = activeDownloads[track.previewURL] else { return }
//        download.task?.cancel() //FIXME: Encapsulation Violation
//        activeDownloads[track.previewURL] = nil
    }
    
    func pause() {
//        download.task?.cancel(byProducingResumeData: { data in download.resumeData = data }) //FIXME: Encapsulation Violation
//        download.isDownloading = false //FIXME: Encapsulation Violation
    }
    
    func resume() {
//        if let resumeData = download.resumeData {
//          download.task = channel.downloadTask(withResumeData: resumeData)
//        } else {
//          download.task = channel.downloadTask(with: download.track.previewURL)
//        }
//        download.task?.resume() //FIXME: Encapsulation Violation
//        download.isDownloading = true //FIXME: Encapsulation Violation
    }
}
