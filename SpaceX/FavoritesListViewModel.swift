import Combine

extension FavoritesList {

    class ViewModel: ObservableObject {

        @Published var launches: [Launch]

        // FavoritesController @Publishes favorites, which it reads from FavoritesStoring.
        // I need the extra layer because I don't know how to define a protocol that @Publishes
        // stuff, so either the storage layer uses a publisher, or we need to "wrap" it into another
        // type that @Publishes for it.
        //
        // The need for a protocol is for testability. In the tests, I want to be able to simulate
        // the different storage behaviors.
        let favoritesController: FavoritesController

        private var cancellables = Set<AnyCancellable>()

        init(favoritesController: FavoritesController) {
            // Stored so we can keep receiving events from it
            self.favoritesController = favoritesController

            self.launches = favoritesController.favorites

            favoritesController.$favorites.sink { [weak self] in
                self?.launches = $0
            }
            .store(in: &cancellables)
        }
    }
}
