
import Foundation

struct Tracks
{
    var tracks: [Track] = [] //FIXME: Be immutable
    let files = Files() //FIXME: Inject
    
    func urlForTrack(at indexPath: IndexPath) -> URL {
        let track = tracks[indexPath.row]
        //let url = files.file(for url: ) //FIXME: Improve Naming
        //let track.url
        return track.previewURL
    }
}

extension Tracks: RandomAccessCollection
{
    typealias Element = Track
    typealias Index = Array<Track>.Index
    
    var startIndex: Index { tracks.startIndex }
    var endIndex: Index { tracks.endIndex }
    
    subscript(position: Index) -> Element {
        get { tracks[position] }
        //setter for mutable
    }
}
