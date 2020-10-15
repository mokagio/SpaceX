import Combine

class FavoritesController: ObservableObject {

    @Published private(set) var favorites = [Launch]()

    private let favoritesStorage: FavoritesStoring

    // TODO: Using in memory storage for now
    init(favoritesStorage: FavoritesStoring = InMemoryFavoritesStore()) {
        self.favoritesStorage = favoritesStorage
    }

    func add(_ launch: Launch) {
        favoritesStorage.add(launch)
        favorites = favoritesStorage.getFavorites()
    }

    func remove(_ launch: Launch) {
        favoritesStorage.remove(launch)
        favorites = favoritesStorage.getFavorites()
    }
}
