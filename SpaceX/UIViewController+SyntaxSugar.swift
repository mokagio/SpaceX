import UIKit

extension UIViewController {

    // TODO: add image
    func with(title: String) -> Self {
        tabBarItem = UITabBarItem(title: title, image: .none, selectedImage: .none)
        return self
    }
}
