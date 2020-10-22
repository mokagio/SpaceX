@testable import SpaceXer
import XCTest

class LaunchDetailViewModelTests: XCTestCase {

    typealias ViewModel = LaunchDetail.ViewModel

    func testViewModelUsesNameFromModel() {
        let viewModel = ViewModel(
            launch: .fixture(name: "name"),
            favoritesController: FavoritesController()
        )
        XCTAssertEqual(viewModel.name, "name")
    }

    func testViewModelUsesTimeIntervalSinceLaunchDate() {
        let modelDate = Date()
        let oneDayAfter = modelDate.addingTimeInterval(24 * 60 * 60)
        let viewModel = ViewModel(
            launch: .fixture(id: "id", date: modelDate),
            favoritesController: FavoritesController(),
            currentDate: oneDayAfter
        )
        XCTAssertEqual(viewModel.timeSinceLaunch, "86400")
    }
}
