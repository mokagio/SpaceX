import UIKit

extension UINavigationController {

    func with(prefersLargeTitles: Bool) -> Self {
        navigationBar.prefersLargeTitles = prefersLargeTitles
        return self
    }
}
