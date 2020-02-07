
import Foundation

class Download
{
    let task: URLSessionDownloadTask
    let track: Track2
    let channel: URLSession
    
    init(track: Track2, channel: URLSession) {
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

extension AppDelegate: URLSessionDownloadDelegate   //FIXME: DownloadDelegate
{
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask,
                    didFinishDownloadingTo location: URL)
    {
        //    guard let sourceURL = downloadTask.originalRequest?.url else { return }
        //    let download = downloadService.activeDownloads[sourceURL]
        //    downloadService.activeDownloads[sourceURL] = nil  //removing from active downloads
        //
        //    let path = files.path(for: url)
        //      files.removeFile(at: path)
        //      files.copyFile(at: path)
        //      update the tableViewCell
        
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
