@testable import SpaceX
import XCTest

class TransformLaunchToSectionsByNameTests: XCTestCase {

    func testLaunchesArrayIntoSectionsByName() {
        let inputs = [
            Launch.fixture(name: "ccc"),
            Launch.fixture(name: "bbb"),
            Launch.fixture(name: "aab"),
            Launch.fixture(name: "bab")
        ]

        let sections = groupLaunchesIntoSectionsByName(inputs)

        // It's good to test for the expected lenght to avoid index out of range crashes. A test
        // failure is easier to understand than a crash.
        XCTAssertEqual(sections.count, 3)

        XCTAssertEqual(
            sections[0],
            SectionSource<Launch>(title: "A", items: [.fixture(name: "aab")])
        )
        XCTAssertEqual(
            sections[1],
            SectionSource<Launch>(title: "B", items: [.fixture(name: "bab"), .fixture(name: "bbb")])
        )
        XCTAssertEqual(
            sections[2],
            SectionSource<Launch>(title: "C", items: [.fixture(name: "ccc")])
        )
    }
}
