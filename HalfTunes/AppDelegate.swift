
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    var backgroundSessionCompletionHandler: (() -> Void)?
    let window = UIWindow.init(frame: UIScreen.main.bounds)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window.makeKeyAndVisible()
        window.rootViewController = app()
        return true
    }
    
    func application(_ application: UIApplication, handleEventsForBackgroundURLSession handleEventsForBackgroundURLSessionidentifier: String, completionHandler: @escaping () -> Void) {
        //FIXME: What is this doing?
        backgroundSessionCompletionHandler = completionHandler
    }
    
    func app() -> UIViewController {
        let defaultChannel = URLSession(configuration: .default, delegate: nil, delegateQueue: nil) //(configuration: .default)
        let sE = SearchEngine(appleMusic: AppleMusic(channel: defaultChannel))
        
        //let backgroundChannel = URLSession(configuration: .background(withIdentifier: "com.sphericalwave.StreamMusic.session"), delegate: self, delegateQueue: nil)
        //let localTracks = LocalTracks(channel: backgroundChannel)   //FIXME: Do i need two channels?
        //channel.delegate = downloadService  //FIXME: That's a challenge
        
        let musicSearchScreen = MusicSearchScreen(searchEngine: sE) //, localTracks: localTracks)
        sE.searchEngineDelegate = musicSearchScreen
        return BatNav(mainScreen: musicSearchScreen)
    }
}

extension AppDelegate: URLSessionDelegate   //FIXME: ChannelDelegate
{
    //FIXME:
    //when background transfer requires completes/requires credentials
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
//        DispatchQueue.main.async {
//            let completionHandler = self.backgroundSessionCompletionHandler {
//                appDelegate.backgroundSessionCompletionHandler = nil
//                completionHandler()
//            }
//        }
    }
}

