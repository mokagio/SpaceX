import Combine

// TODO: Probably want to put a protocol in front of this for testing
class FavoritesController: ObservableObject {

    @Published private(set) var favorites = [Launch]()

    // TODO: Using in memory storage for now
    private var favoritesStorage = Set<Launch>()

    func add(_ launch: Launch) {
        favoritesStorage.insert(launch)
        favorites = getFavorites()
    }

    func remove(_ launch: Launch) {
        favoritesStorage.remove(launch)
        favorites = getFavorites()
    }

    private func getFavorites() -> [Launch] {
        return favoritesStorage.sorted { $0.dateUnix < $1.dateUnix }
    }
}
