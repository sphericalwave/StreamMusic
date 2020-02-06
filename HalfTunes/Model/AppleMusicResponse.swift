
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
