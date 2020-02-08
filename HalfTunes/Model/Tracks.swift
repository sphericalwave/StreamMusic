
import Foundation

struct Tracks
{
    let tracks: [Track2]
    
    init(data: Data) {
        let decoder = JSONDecoder()
        do {
            let appleMusicResponse = try decoder.decode(AppleMusicResponse.self, from: data)
            self.tracks = appleMusicResponse.tracks
        }
        catch { fatalError() }
    }
    
    func urlForTrack(at indexPath: IndexPath) -> URL {
        let track = tracks[indexPath.row]
        return track.previewURL
    }
}

extension Tracks: RandomAccessCollection
{
    typealias Element = Track2
    typealias Index = Array<Track2>.Index
    
    var startIndex: Index { tracks.startIndex }
    var endIndex: Index { tracks.endIndex }
    
    subscript(position: Index) -> Element {
        get { tracks[position] }
        //setter for mutable
    }
}
