import Combine

// TODO: Probably want to put a protocol in front of this for testing
class FavoritesController: ObservableObject {

    // TODO: Using in memory storage for now
    @Published private(set) var favorites = Set<Launch>()

    func add(_ launch: Launch) {
        favorites.insert(launch)
    }

    func remove(_ launch: Launch) {
        favorites.remove(launch)
    }
}
