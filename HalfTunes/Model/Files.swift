
import Foundation

class Files: NSObject
{
    /// Get local file path: download task stores tune here; AV player plays it.
    let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    func path(for url: URL) -> URL {
        return documentsPath.appendingPathComponent(url.lastPathComponent)
    }
}

extension Files: URLSessionDownloadDelegate   //FIXME: DownloadDelegate
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
