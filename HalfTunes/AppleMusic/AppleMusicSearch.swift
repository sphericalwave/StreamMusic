
import Foundation

class AppleMusicSearch
{
    var urlComponents: URLComponents    //FIXME: Framework Demands Var
    
    init(search: String) {
        guard var urlComponents = URLComponents(string: "https://itunes.apple.com/search") else { fatalError() }
        urlComponents.query = "media=music&entity=song&term=\(search)"
        self.urlComponents = urlComponents
    }
    
    func url() -> URL {
        guard let url = urlComponents.url else { fatalError() }
        return url
    }
}
