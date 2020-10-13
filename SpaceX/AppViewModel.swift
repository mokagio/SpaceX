/// The entry-point view-model for the whole application.
///
/// This makes dependency inversion possible as well as decoupling SwitfUI components from having to
/// know how to build the views they navigates to
class AppViewModel {

    init() {}

    func makeLaunchListContainerViewModel() -> LaunchesListContainer.ViewModel {
        return LaunchesListContainer.ViewModel()
    }
}

