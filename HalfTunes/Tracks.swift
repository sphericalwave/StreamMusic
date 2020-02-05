
import Foundation

struct Tracks
{
    var tracks: [Track] = [] //FIXME: Be immutable
    
//    func track(at index: Int) -> Track {
//        return tracks[index]
//    }
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
