/// The entry-point view-model for the whole application.
///
/// This makes dependency inversion possible as well as decoupling SwitfUI components from having to
/// know how to build the views they navigates to
class AppViewModel {

    let favoritesController = FavoritesController()

    func makeLaunchListContainerViewModel() -> LaunchesListContainer.ViewModel {
        return LaunchesListContainer.ViewModel(
            launchDetailGetter: { [unowned self] in
                LaunchDetail(
                    viewModel: .init(launch: $0, favoritesController: self.favoritesController)
                )
            }
        )
    }

    func makeFavoritesListViewModel() -> FavoritesList.ViewModel {
        return FavoritesList.ViewModel(favoritesController: favoritesController)
    }
}
