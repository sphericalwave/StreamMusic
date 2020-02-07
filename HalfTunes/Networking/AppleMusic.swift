
import Foundation

class AppleMusic: NSObject
{
    let channel: URLSession //FIXME: Change type to Channel
    
    init(channel: URLSession) { self.channel = channel }
    
    //Called By Z SearchEngine
    func tracksMatching(searchTerm: String, callback: @escaping ( (Tracks) -> Void ) ) {
        let appleMusicSearch = AppleMusicSearch(search: searchTerm)
        let dataTask = channel.dataTask(with: appleMusicSearch.URL()) { data, response, error in
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
