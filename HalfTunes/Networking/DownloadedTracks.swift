
import UIKit

/// Downloads song snippets, and stores in local file.
/// Allows cancel, pause, resume download.
class DownloadedTracks: NSObject
{
    var activeDownloads: [URL: Download] = [ : ]  //FIXME: Be Immutable...make a ActiveDownloads class
    let channel: URLSession
    
    init(channel: URLSession) { self.channel = channel }
    
    func cancelDownload(_ track: Track) {
        guard let download = activeDownloads[track.previewURL] else { fatalError() }
        download.cancel()
        activeDownloads[track.previewURL] = nil   //remove Download
    }
    
    func pauseDownload(_ track: Track) {
        guard let download = activeDownloads[track.previewURL] else { fatalError() }
        download.pause()
    }
    
    func resumeDownload(_ track: Track) {
        guard let download = activeDownloads[track.previewURL] else { return }
        download.resume()
    }
    
    func startDownload(_ track: Track) {
        let download = Download(track: track, channel: channel)
        activeDownloads[download.track.previewURL] = download
    }
}

extension DownloadedTracks: URLSessionDelegate
{
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        //FIXME: This is awful
        //    DispatchQueue.main.async {
        //      if let appDelegate = UIApplication.shared.delegate as? AppDelegate,
        //        let completionHandler = appDelegate.backgroundSessionCompletionHandler {
        //        appDelegate.backgroundSessionCompletionHandler = nil
        //        completionHandler()
        //      }
        //    }
    }
}

extension DownloadedTracks: URLSessionDownloadDelegate
{
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask,
                    didFinishDownloadingTo location: URL)
    {
        //    guard let sourceURL = downloadTask.originalRequest?.url else { return }
        //    let download = downloadService.activeDownloads[sourceURL]
        //    downloadService.activeDownloads[sourceURL] = nil  //removing from active downloads
        //
        //    let destinationURL = localFilePath(for: sourceURL)
        //    print(destinationURL)
        //
        //    let fileManager = FileManager.default
        //    try? fileManager.removeItem(at: destinationURL)
        //
        //    do {
        //      try fileManager.copyItem(at: location, to: destinationURL)
        //      download?.track.downloaded = true
        //    } catch let error {
        //      print("Could not copy file to disk: \(error.localizedDescription)")
        //    }
        //
        //    if let index = download?.track.index {
        //      DispatchQueue.main.async { [weak self] in
        //        self?.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
        //      }
        //    }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask,
                    didWriteData bytesWritten: Int64, totalBytesWritten: Int64,
                    totalBytesExpectedToWrite: Int64) {
        //    guard
        //      let url = downloadTask.originalRequest?.url,
        //      let download = downloadService.activeDownloads[url]  else {
        //        return
        //    }
        //
        //    download.progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        //    let totalSize = ByteCountFormatter.string(fromByteCount: totalBytesExpectedToWrite, countStyle: .file)
        //
        //    DispatchQueue.main.async {
        ////      if let trackCell = self.tableView.cellForRow(at: IndexPath(row: download.track.index,
        ////                                                                 section: 0)) as? TrackCell {
        ////        trackCell.updateDisplay(progress: download.progress, totalSize: totalSize)
        ////      }
        //    }
    }
}
