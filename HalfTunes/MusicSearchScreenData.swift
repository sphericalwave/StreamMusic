
import UIKit

class MusicSearchScreenData
{
    func numberOfRows() -> Int {
        //return tracks?.count ?? 0   //FIXME: Not a fan
        return 1  //FIXME:
    }
    
    func heightForRowAt(indexPath: IndexPath) -> CGFloat {
        return 81.0
    }
    
    func trackCellForRow(at indexPath: IndexPath) -> TrackCell? {
//        guard let track = tracks?[indexPath.row] else { fatalError() }
//         let trackCell = TrackCell(track: track, downloadedTracks: downloadedTracks, files: Files()) //FIXME: Inject Files
        return nil //FIXME:
    }
    
    func trackUrlForRow(at indexPath: IndexPath) -> URL? {
        return nil  //FIXME:
    }
}
