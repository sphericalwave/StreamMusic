
import UIKit

class StreamMusic: UINavigationController
{
  init() {
    let sRS = UIViewController()
    sRS.view.backgroundColor = .green
    let sE = SearchEngine(searchResultsScreen: nil, queryService: QueryService())
    
    let configuration = URLSessionConfiguration.background(withIdentifier: "com.sphericalwave.StreamMusic.bgSession")
    let channel = URLSession(configuration: configuration)
    let downloadService = DownloadService(channel: channel)
    //channel.delegate = downloadService  //FIXME: That's a challenge
    let mSS = MusicSearchScreen(searchEngine: sE, downloadService: downloadService)
    
    //sE.searchResultsUpdater = mSS
    sE.searchEngineDelegate = mSS
    super.init(rootViewController: mSS)
    navigationBar.barStyle = .black
    navigationBar.isTranslucent = false
  }
  
  required init?(coder aDecoder: NSCoder) { fatalError() }
}
