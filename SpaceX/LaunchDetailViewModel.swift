import Foundation

extension LaunchDetail {

    class ViewModel: ObservableObject {
        private let launch: Launch

        let name: String
        let timeSinceLaunch: String

        @Published var shouldShowAddToFavorites: Bool

        // TODO: Inject instead
        let favoritesController: FavoritesController = FavoritesController()

        init(launch: Launch, currentDate: Date = Date()) {
            self.launch = launch
            name = launch.name
            timeSinceLaunch = "\(currentDate.timeIntervalSince(launch.date).rounded().toInt())"
            shouldShowAddToFavorites = favoritesController.favorites.contains(launch) == false
        }

        func addToFavorites() {
            favoritesController.add(launch)
            shouldShowAddToFavorites = getShouldShouldAddToFavorites()
        }

        func removeFromFavorites() {
            favoritesController.remove(launch)
            shouldShowAddToFavorites = getShouldShouldAddToFavorites()
        }

        private func getShouldShouldAddToFavorites() -> Bool {
            return favoritesController.favorites.contains(launch) == false
        }
    }
}
