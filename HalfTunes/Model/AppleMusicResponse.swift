
import Foundation

struct AppleMusicResponse: Codable
{
  let trackCount: Int
  let tracks: [Track2]
  
  private enum CodingKeys: String, CodingKey {
      case trackCount = "resultCount"
      case tracks = "results"
  }
}

struct Track2: Codable
{
    let artist: String
    //let index: Int
    let name: String
    let previewURL: URL
    
    private enum CodingKeys: String, CodingKey {
        case artist = "artistName"
        //case index
        case name = "trackName"
        case previewURL = "previewUrl"
    }
}
