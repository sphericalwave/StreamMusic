
import Foundation

class Files: NSObject
{
    /// Get local file path: download task stores tune here; AV player plays it.
    let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    func path(for url: URL) -> URL {
        return documentsPath.appendingPathComponent(url.lastPathComponent)
    }
}

//        //    let path = files.path(for: url)
//        //      files.removeFile(at: path)
//        //      files.copyFile(at: path)
//        //      update the tableViewCell
//
//        //    let destinationURL = localFilePath(for: sourceURL)
//        //    print(destinationURL)
//        //
//        //    let fileManager = FileManager.default
//        //    try? fileManager.removeItem(at: destinationURL)
//        //
//        //    do {
//        //      try fileManager.copyItem(at: location, to: destinationURL)
//        //      download?.track.downloaded = true
//        //    } catch let error {
//        //      print("Could not copy file to disk: \(error.localizedDescription)")
//        //    }
//        //
