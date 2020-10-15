// TODO: Probably want to put a protocol in front of this for testing
class FavoritesController {

    // TODO: Using in memory storage for now
    private(set) var favorites = Set<Launch>()

    func add(_ launch: Launch) {
        favorites.insert(launch)
    }
}
