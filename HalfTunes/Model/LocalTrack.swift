

import Foundation

struct LocalTrack
{
    let artist: String
    let name: String
    let previewURL: URL
    let download: URLSessionDownloadTask
    let files: Files
    
    func startDownload() {
        //let download = Download(track: track, channel: channel)
        //FIXME: download.task.delegate
        //activeDownloads[download.track.previewURL] = download
        download.resume()
    }
    
    func pauseDownload() {
        //FIXME: Where shall i store the data?
        //download.cancel(byProducingResumeData: <#T##(Data?) -> Void#>)
    }
    
    func resumeDownload() { download.resume() }
    
    func cancelDownload() { download.cancel() }
}
