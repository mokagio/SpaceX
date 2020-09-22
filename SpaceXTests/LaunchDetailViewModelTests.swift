@testable import SpaceX
import XCTest

class LaunchDetailViewModelTests: XCTestCase {

    typealias ViewModel = LaunchDetail.ViewModel

    func testViewModelUsesNameFromModel() {
        XCTAssertEqual(ViewModel.from(.fixture(name: "name")).name, "name")
    }

    func testViewModelUsesTimeIntervalSinceLaunchDate() {
        let modelDate = Date()
        let oneDayAfter = modelDate.addingTimeInterval(24 * 60 * 60)
        let viewModel = ViewModel.from(.fixture(id: "id", date: modelDate), date: oneDayAfter)
        XCTAssertEqual(viewModel.timeSinceLaunch, "86400")
    }
}
