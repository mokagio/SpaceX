import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    let viewModel = AppViewModel()

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided
        // UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and
        // attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see
        // `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene

        /** Originally, I wanted to use this as an experiment to compare UIKit and SwiftUI stuff and
            how to use business logic across both, but right now I'm more interested in learning
            more about how to test SwiftUI and Combine.

        let launchesContainerView = LaunchesListContainer(viewModel: viewModel.makeLaunchListContainerViewModel())
        let tab = UITabBarController()
        tab.viewControllers = [
            UIHostingController(rootView: launchesContainerView)
                .with(title: "Swift UI"),
            UINavigationController(rootViewController: UIKitLaunchListViewController().with(title: "SpaceXer Launches 🚀"))
                .with(title: "UIKit")
                .with(prefersLargeTitles: true)
        ]
        _ = tab.view

        window?.rootViewController = tab
         */

        window?.rootViewController = getRootViewController()
        window?.makeKeyAndVisible()
    }

    private func getRootViewController() -> UIViewController {
        let view = TabView {
            LaunchesListContainer(viewModel: viewModel.makeLaunchListContainerViewModel())
                .tabItem { Text("Launches") }
            NavigationView {
                FavoritesList(viewModel: viewModel.makeFavoritesListViewModel())
                    .navigationBarTitle("Favorites 💜")
            }
            .tabItem { Text("Favorites") }
        }

        return UIHostingController(rootView: view)
    }
}
