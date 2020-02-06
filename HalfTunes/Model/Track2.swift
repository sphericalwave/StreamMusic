
import Foundation

struct Track2: Codable
{
    let artist: String
    let name: String
    let previewURL: URL
    
    private enum CodingKeys: String, CodingKey {
        case artist = "artistName"
        case name = "trackName"
        case previewURL = "previewUrl"
    }
}
