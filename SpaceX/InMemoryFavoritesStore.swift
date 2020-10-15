class InMemoryFavoritesStore: FavoritesStoring {

    private var storage = Set<Launch>()

    func add(_ launch: Launch) {
        storage.insert(launch)
    }

    func remove(_ launch: Launch) {
        storage.remove(launch)
    }

    func getFavorites() -> [Launch] {
        return storage.sorted { $0.dateUnix < $1.dateUnix }
    }
}
