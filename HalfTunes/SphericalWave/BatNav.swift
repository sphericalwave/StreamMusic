
import UIKit

class BatNav: UINavigationController   //FIXME: Rename to Nav
{
    init(mainScreen: UIViewController) {
        super.init(rootViewController: mainScreen)
        navigationBar.barStyle = .black
        navigationBar.isTranslucent = false
    }
    required init?(coder aDecoder: NSCoder) { fatalError() }
}
