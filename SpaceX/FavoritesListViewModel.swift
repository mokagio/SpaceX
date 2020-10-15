import Combine

extension FavoritesList {

    class ViewModel: ObservableObject {

        @Published var launches: [Launch]

        let favoritesController: FavoritesController
        private var cancellables = Set<AnyCancellable>()

        init(favoritesController: FavoritesController) {
            // Stored so we can keep receiving events from it
            self.favoritesController = favoritesController

            self.launches = favoritesController.favorites.sorted { $0.dateUnix < $1.dateUnix }

            favoritesController.$favorites.sink { [weak self] in
                self?.launches = $0.sorted { $0.dateUnix < $1.dateUnix }
            }
            .store(in: &cancellables)
        }
    }
}
