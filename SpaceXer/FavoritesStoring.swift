/// Defines the qualities of a storage layer for launches
protocol FavoritesStoring {

    func getFavorites() -> [Launch]

    func add(_ launch: Launch)

    func remove(_ launch: Launch)
}
