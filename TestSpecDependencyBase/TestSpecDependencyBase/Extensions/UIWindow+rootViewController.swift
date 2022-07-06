import UIKit

public extension UIWindow {
    convenience init(rootViewController: UIViewController) {
        self.init()
        self.rootViewController = rootViewController
    }
}
