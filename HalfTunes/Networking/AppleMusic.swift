
import Foundation

/// Runs query data task, and stores results in array of Tracks
class AppleMusic
{
    var dataTask: URLSessionDataTask? //FIXME: Be Immutable, URLSessionDataTask >> Download
    var errorMessage = ""             //FIXME: Be Immutable
    var tracks: [Track] = []          //FIXME: Be Immutable
    
    let channel: URLSession //FIXME: Change type to Channel
    
    init(channel: URLSession) {
        self.channel = channel
    }
    
    func tracksMatching(searchTerm: String, completion: @escaping ([Track]?, String) -> Void) {
        dataTask?.cancel()  //cancel current data task...better name?
        
        var urlComponents = URLComponents(string: "https://itunes.apple.com/search")  //FIXME: Framework demands var
        urlComponents?.query = "media=music&entity=song&term=\(searchTerm)"
        guard let url = urlComponents?.url else { return }
        
        dataTask = channel.dataTask(with: url) { [weak self] data, response, error in
            defer { self?.dataTask = nil } //FIXME: nil
            guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                guard let error = error else { fatalError() }
                print(error)
                self?.errorMessage += "DataTask error: " + error.localizedDescription + "\n"  //FIXME: Be Immutable
                return
            }
            //print(response) //HTTP Response
            //print(String(decoding: data, as: UTF8.self))
            self?.updateSearchResults(data)
            DispatchQueue.main.async { completion(self?.tracks, self?.errorMessage ?? "") }
        }
        dataTask?.resume()
    }
    
    private func updateSearchResults(_ data: Data) {
        tracks.removeAll()  //FIXME: Implies Mutable State
        var index = 0
        let decoder = JSONDecoder()
        do {
            let appleMusicResponse = try decoder.decode(AppleMusicResponse.self, from: data)
            let tracks2 = appleMusicResponse.tracks
            for track in tracks2 {
                tracks.append(Track(name: track.name, artist: track.artist, previewURL: track.previewURL, index: index))
                index += 1  //FIXME: Remove need for this index
            }
        }
        catch { fatalError() }
    }
}
