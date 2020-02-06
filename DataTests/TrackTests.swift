@testable import HalfTunes
import XCTest

class TrackTests: XCTestCase
{
    let decoder = JSONDecoder()
    let encoder = JSONEncoder()
    
    override func setUp() {
      //TODO: Not Neccessary in this case
      //encoder.keyEncodingStrategy = .convertToSnakeCase
      //decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    override func tearDown() {
    }
    
    func testSerialization() {
      //print(appleMusicJson)
      guard let jsonData = appleMusicJson.data(using: .utf8) else { fatalError() }
      do {
        let appleMusicResponse = try decoder.decode(AppleMusicResponse.self, from: jsonData)
        XCTAssertEqual(appleMusicResponse.trackCount, appleMusicResponse.tracks.count)
        let track1 = appleMusicResponse.tracks[0]
        XCTAssertNotNil(track1.artist)
        XCTAssertNotNil(track1.name)
        XCTAssertNotNil(track1.previewURL)
      }
      catch {
        print(error.localizedDescription)
        XCTFail()
      }
    }
  
}

let appleMusicJson = """
  {
   "resultCount":2,
   "results": [
      {"wrapperType":"track", "kind":"song", "artistId":1093360, "collectionId":991509751, "trackId":991509754, "artistName":"Muse", "collectionName":"The Resistance", "trackName":"Uprising", "collectionCensoredName":"The Resistance", "trackCensoredName":"Uprising", "artistViewUrl":"https://music.apple.com/us/artist/muse/1093360?uo=4", "collectionViewUrl":"https://music.apple.com/us/album/uprising/991509751?i=991509754&uo=4", "trackViewUrl":"https://music.apple.com/us/album/uprising/991509751?i=991509754&uo=4", "previewUrl":"https://audio-ssl.itunes.apple.com/itunes-assets/Music7/v4/c7/9d/47/c79d4764-061a-27ce-59b9-d2d5b5c6ce7e/mzaf_4644533900398680324.plus.aac.p.m4a", "artworkUrl30":"https://is5-ssl.mzstatic.com/image/thumb/Music1/v4/f5/9f/ec/f59fec5d-5ce1-f226-d7bb-3204eddb9337/source/30x30bb.jpg", "artworkUrl60":"https://is5-ssl.mzstatic.com/image/thumb/Music1/v4/f5/9f/ec/f59fec5d-5ce1-f226-d7bb-3204eddb9337/source/60x60bb.jpg", "artworkUrl100":"https://is5-ssl.mzstatic.com/image/thumb/Music1/v4/f5/9f/ec/f59fec5d-5ce1-f226-d7bb-3204eddb9337/source/100x100bb.jpg", "collectionPrice":9.99, "trackPrice":1.29, "releaseDate":"2009-08-04T07:00:00Z", "collectionExplicitness":"notExplicit", "trackExplicitness":"notExplicit", "discCount":1, "discNumber":1, "trackCount":11, "trackNumber":1, "trackTimeMillis":302827, "country":"USA", "currency":"USD", "primaryGenreName":"Alternative", "isStreamable":true
      },
      {"wrapperType":"track", "kind":"song", "artistId":1093360, "collectionId":563015686, "trackId":563015727, "artistName":"Muse", "collectionName":"The 2nd Law (Deluxe Version)", "trackName":"The 2nd Law - Unsustainable", "collectionCensoredName":"The 2nd Law (Deluxe Version)", "trackCensoredName":"The 2nd Law - Unsustainable", "artistViewUrl":"https://music.apple.com/us/artist/muse/1093360?uo=4", "collectionViewUrl":"https://music.apple.com/us/album/the-2nd-law-unsustainable/563015686?i=563015727&uo=4", "trackViewUrl":"https://music.apple.com/us/album/the-2nd-law-unsustainable/563015686?i=563015727&uo=4", "previewUrl":"https://audio-ssl.itunes.apple.com/itunes-assets/Music/ee/ad/6f/mzi.fjemdpms.aac.p.m4a", "artworkUrl30":"https://is5-ssl.mzstatic.com/image/thumb/Music/v4/c6/ba/74/c6ba7436-65c1-8fa6-3606-4d3dbb7f32e1/source/30x30bb.jpg", "artworkUrl60":"https://is5-ssl.mzstatic.com/image/thumb/Music/v4/c6/ba/74/c6ba7436-65c1-8fa6-3606-4d3dbb7f32e1/source/60x60bb.jpg", "artworkUrl100":"https://is5-ssl.mzstatic.com/image/thumb/Music/v4/c6/ba/74/c6ba7436-65c1-8fa6-3606-4d3dbb7f32e1/source/100x100bb.jpg", "collectionPrice":11.99, "trackPrice":1.29, "releaseDate":"2012-09-28T07:00:00Z", "collectionExplicitness":"explicit", "trackExplicitness":"notExplicit", "discCount":1, "discNumber":1, "trackCount":13, "trackNumber":12, "trackTimeMillis":228059, "country":"USA", "currency":"USD", "primaryGenreName":"Alternative", "isStreamable":true
      }
    ]
  }
  """
