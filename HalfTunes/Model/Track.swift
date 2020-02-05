
import Foundation.NSURL

/// Query service creates Track objects
class Track
{
    let artist: String
    let index: Int
    let name: String
    let previewURL: URL
    var downloaded = false  //FIXME: Be Immutable
    
    init(name: String, artist: String, previewURL: URL, index: Int) {
        self.name = name
        self.artist = artist
        self.previewURL = previewURL
        self.index = index
    }
}
