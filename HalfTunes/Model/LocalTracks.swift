
//import UIKit
//
///// Downloads song snippets, and stores in local file.
//class LocalTracks: NSObject
//{
//    var activeDownloads: [URL: Download] = [ : ]  //FIXME: Be Immutable...make a ActiveDownloads class
//    let channel: URLSession
//    let files = Files()  //FIXME: Inject Me
//    
//    init(channel: URLSession) { self.channel = channel }
//    
//    func startDownload(_ track: Track2) {
//        let download = Download(track: track, channel: channel)
//        //FIXME: download.task.delegate
//        activeDownloads[download.track.previewURL] = download
//    }
//    
//    func pauseDownload(_ track: Track2) {
//        guard let download = activeDownloads[track.previewURL] else { fatalError() }
//        download.pause()
//    }
//    
//    func resumeDownload(_ track: Track2) {
//        guard let download = activeDownloads[track.previewURL] else { return }
//        download.resume()
//    }
//    
//    func cancelDownload(_ track: Track2) {
//        guard let download = activeDownloads[track.previewURL] else { fatalError() }
//        download.cancel()
//        activeDownloads[track.previewURL] = nil   //remove Download
//    }
//}
