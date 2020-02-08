
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    let window = UIWindow.init(frame: UIScreen.main.bounds)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window.makeKeyAndVisible()
        window.rootViewController = app()
        return true
    }
    
    func application(_ application: UIApplication, handleEventsForBackgroundURLSession handleEventsForBackgroundURLSessionidentifier: String, completionHandler: @escaping () -> Void) {
        //FIXME: How BackgroundSession Events
    }
    
    func app() -> UIViewController {
        let defaultChannel = URLSession(configuration: .default)
        let sE = SearchEngine(appleMusic: AppleMusic(channel: defaultChannel))
        let musicSearchScreen = MusicSearchScreen(searchEngine: sE, channel: defaultChannel)
        sE.searchEngineDelegate = musicSearchScreen
        return BatNav(mainScreen: musicSearchScreen)
    }
}
