
import UIKit

class StreamMusic: UINavigationController
{
    init() {
        let sRS = UIViewController()
        sRS.view.backgroundColor = .green
        let channel = URLSession(configuration: .default)
        let sE = SearchEngine(searchResultsScreen: nil, appleMusic: AppleMusic(channel: channel))
        
        let configuration = URLSessionConfiguration.background(withIdentifier: "com.sphericalwave.StreamMusic.bgSession")
        let backgroundChannel = URLSession(configuration: configuration)
        let downloadedTracks = DownloadedTracks(channel: backgroundChannel)   //FIXME: Do i need two channels?
        //channel.delegate = downloadService  //FIXME: That's a challenge
        let mSS = MusicSearchScreen(searchEngine: sE, downloadedTracks: downloadedTracks)
        
        //sE.searchResultsUpdater = mSS
        sE.searchEngineDelegate = mSS
        super.init(rootViewController: mSS)
        navigationBar.barStyle = .black
        navigationBar.isTranslucent = false
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError() }
}
