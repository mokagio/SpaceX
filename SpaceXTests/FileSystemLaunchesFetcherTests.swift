@testable import SpaceX
import XCTest

class FileSystemLaunchFetcherTests: XCTestCase {

    func testFetchFromJSONFile() throws {
        let bundle = Bundle(for: type(of: self))
        let jsonURL = try XCTUnwrap(bundle.url(forResource: "past_launches", withExtension: "json"))
        let fetcher = FileSystemLaunchesFetcher(url: jsonURL)

        assertReceivesValue(fetcher.fetch()) { sections in
            XCTAssertEqual(sections.count, 14)
            XCTAssertEqual(sections[safe: 0]?.title, "2006")
        }
    }
}
