
import Foundation

class AppleMusic: NSObject
{
    let channel: URLSession //FIXME: Change type to Channel? A session is a thing. The channel has sessions.
    
    init(channel: URLSession) { self.channel = channel }
    
    func tracksMatching(searchTerm: String, callback: @escaping ( (Tracks) -> Void ) ) {
        let appleMusicSearch = AppleMusicSearch(search: searchTerm)
        let dataTask = channel.dataTask(with: appleMusicSearch.url()) { data, response, error in
            guard let data = data else {
                print(error!.localizedDescription) //FIXME: Fragile
                fatalError()
            }
            let tracks = Tracks(data: data)
            DispatchQueue.main.async { callback(tracks) }
        }
        dataTask.resume()
    }
}
