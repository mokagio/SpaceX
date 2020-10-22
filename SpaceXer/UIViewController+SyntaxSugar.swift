import UIKit

extension UIViewController {

    func with(tabTitle: String, image: UIImage? = .none) -> Self {
        tabBarItem = UITabBarItem(title: tabTitle, image: image, selectedImage: .none)
        return self
    }

    func with(title: String) -> Self {
        self.title = title
        return self
    }
}

extension UIViewController {

    func pin(_ viewToPin: UIView, to viewPinningTo: UIView) {
        // We don't know whether the caller did this for us, might be redundant, but let's do it
        // just in case.
        viewToPin.translatesAutoresizingMaskIntoConstraints = false

        viewPinningTo.addConstraints(
            [
                .init(making: .top, of: viewToPin, equalTo: viewPinningTo),
                .init(making: .left, of: viewToPin, equalTo: viewPinningTo),
                .init(making: .bottom, of: viewToPin, equalTo: viewPinningTo),
                .init(making: .right, of: viewToPin, equalTo: viewPinningTo)
            ]
        )
    }
}
