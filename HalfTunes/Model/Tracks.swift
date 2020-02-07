
import Foundation

struct Tracks
{
    //var tracks: [Track] = [] //FIXME: Be immutable
    let files = Files() //FIXME: Inject
    let tracks: [Track2]
    
    init(data: Data) {
        //tracks.removeAll()  //FIXME: Implies Mutable State
        //var index = 0
        let decoder = JSONDecoder()
        do {
            let appleMusicResponse = try decoder.decode(AppleMusicResponse.self, from: data)
            self.tracks = appleMusicResponse.tracks
//            for track in tracks2 {
//                tracks.append(Track(name: track.name, artist: track.artist, previewURL: track.previewURL, index: index))
//                //index += 1  //FIXME: Remove need for this index
//            }
        }
        catch { fatalError() }
    }
    
    func urlForTrack(at indexPath: IndexPath) -> URL {
        let track = tracks[indexPath.row]
        //let url = files.file(for url: ) //FIXME: Improve Naming
        //let track.url
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
