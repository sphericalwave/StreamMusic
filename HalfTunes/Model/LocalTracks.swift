
import Foundation

class LocalTracks
{
    let files = Files() //FIXME: Inject...db
    let tracks: [LocalTrack]
    let channel: URLSession
    
    init(tracks: [LocalTrack], channel: URLSession) {
        self.channel = channel
        
//        let tracks = tracks.map { LocalTrack(track2: $0, download: channel.downloadTask(with: $0.previewURL), files: files) }
        self.tracks = tracks
    }
    
    func urlForTrack(at indexPath: IndexPath) -> URL {
        let track = tracks[indexPath.row]
        return track.previewURL()
    }
    
    func add(track: LocalTrack) {
        
    }
    
    func delete(track: LocalTrack) {
        
    }
}

extension LocalTracks: RandomAccessCollection
{
    typealias Element = LocalTrack
    typealias Index = Array<LocalTrack>.Index
    
    var startIndex: Index { tracks.startIndex }
    var endIndex: Index { tracks.endIndex }
    
    subscript(position: Index) -> Element {
        get { tracks[position] }
        //setter for mutable
    }
}


