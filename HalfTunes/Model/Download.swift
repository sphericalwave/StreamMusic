
import Foundation

class Download
{
    let task: URLSessionDownloadTask
    let track: Track
    let channel: URLSession
    
    init(track: Track, channel: URLSession) {
        self.track = track
        self.channel = channel
        self.task = channel.downloadTask(with: track.previewURL)
    }
    
    func state() -> URLSessionTask.State { return task.state }
    
    func progress() -> Progress { return task.progress }
    
    func start() { task.resume() }
    
    func cancel() { task.cancel() }
    
    func pause() { task.suspend() }
    
    func resume() { task.resume() }
}
