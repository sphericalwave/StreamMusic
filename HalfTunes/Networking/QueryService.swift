
import Foundation

/// Runs query data task, and stores results in array of Tracks
class QueryService
{
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask? //FIXME: Be Immutable
    var errorMessage = ""             //FIXME: Be Immutable
    var tracks: [Track] = []          //FIXME: Be Immutable
    
    typealias JSONDictionary = [String: Any]
    
    func searchResults(searchTerm: String, completion: @escaping ([Track]?, String) -> Void) {
        dataTask?.cancel()  //cancel current data task...better name?
        
        var urlComponents = URLComponents(string: "https://itunes.apple.com/search")  //FIXME: Framework demands var
        urlComponents?.query = "media=music&entity=song&term=\(searchTerm)"
        guard let url = urlComponents?.url else { return }
        
        dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
            defer { self?.dataTask = nil } //FIXME: nil
            guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                guard let error = error else { fatalError() }
                print(error)
                self?.errorMessage += "DataTask error: " + error.localizedDescription + "\n"  //FIXME: Be Immutable
                return
            }
            self?.updateSearchResults(data)
            DispatchQueue.main.async { completion(self?.tracks, self?.errorMessage ?? "") }
        }
        dataTask?.resume()
    }
    
    private func updateSearchResults(_ data: Data) {
        var response: JSONDictionary?
        tracks.removeAll()
        
        do {
            response = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
        } catch let parseError as NSError {
            errorMessage += "JSONSerialization error: \(parseError.localizedDescription)\n"
            return
        }
        
        guard let array = response!["results"] as? [Any] else {
            errorMessage += "Dictionary does not contain results key\n"
            return
        }
        
        var index = 0
        
        //FIXME: Apply Codable
        for trackDictionary in array {
            if let trackDictionary = trackDictionary as? JSONDictionary,
                let previewURLString = trackDictionary["previewUrl"] as? String,
                let previewURL = URL(string: previewURLString),
                let name = trackDictionary["trackName"] as? String,
                let artist = trackDictionary["artistName"] as? String {
                tracks.append(Track(name: name, artist: artist, previewURL: previewURL, index: index))
                index += 1
            } else {
                errorMessage += "Problem parsing trackDictionary\n"
            }
        }
    }
}
