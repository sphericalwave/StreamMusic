
import UIKit

class StreamMusic: UINavigationController
{
  let tintColor =  UIColor(red: 242/255, green: 71/255, blue: 63/255, alpha: 1)
  
  init() {
    let sRS = UIViewController()
    sRS.view.backgroundColor = .green
    let sE = SearchEngine(searchResultsScreen: sRS)
    let mSS = MusicSearchScreen(searchEngine: sE)
    super.init(rootViewController: mSS)
    navigationBar.barStyle = .black
    navigationBar.isTranslucent = false
  }
  
  required init?(coder aDecoder: NSCoder) { fatalError() }
  
//  //FIXME: move this into subclasses
//  private func customizeAppearance() {
//    //window?.tintColor = tintColor
//    UISearchBar.appearance().barTintColor = tintColor
//    UINavigationBar.appearance().barTintColor = tintColor
//    UINavigationBar.appearance().tintColor = UIColor.white
//    let titleTextAttributes = [NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue) : UIColor.white]
//    UINavigationBar.appearance().titleTextAttributes = titleTextAttributes
//  }
}
