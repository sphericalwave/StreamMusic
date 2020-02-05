
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
  var backgroundSessionCompletionHandler: (() -> Void)?
  var window: UIWindow?

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
  {
    window = UIWindow.init(frame: UIScreen.main.bounds)
    window?.makeKeyAndVisible()
    window?.rootViewController = StreamMusic()
    return true
  }
  
  func application(_ application: UIApplication,
                   handleEventsForBackgroundURLSession handleEventsForBackgroundURLSessionidentifier: String,
                   completionHandler: @escaping () -> Void)
  {
    backgroundSessionCompletionHandler = completionHandler
  }
}

//FIXME: Indent by 4 Spaces
