@testable import SpaceX
import XCTest

class TransformLaunchToSectionsByNameTests: XCTestCase {

    func testLaunchesArrayIntoSectionsByYear() {
        let inputs = [
            Launch.fixture(id: "a", date: Date(year: 2020)),
            Launch.fixture(id: "b", date: Date(year: 2019)),
            Launch.fixture(id: "c", date: Date(year: 2020)),
            Launch.fixture(id: "d", date: Date(year: 2021))
        ]

        let sections = groupLaunchesIntoSectionsByName(inputs)

        // It's good to test for the expected lenght to avoid index out of range crashes. A test
        // failure is easier to understand than a crash.
        XCTAssertEqual(sections.count, 3)

        XCTAssertEqual(sections[0].title, "2019")
        XCTAssertEqual(sections[1].title, "2020")
        XCTAssertEqual(sections[2].title, "2021")
    }
}
