// I have no idea what I'm doing here, but I'm trying to understand how to use combine to read
// data from the filesystem (and eventually from the network).
// I'm not sure about the naming, I'm not sure about the pattern.
//
// Resources I checked out:
// - https://medium.com/@rbreve/displaying-a-list-with-swiftui-from-a-remote-json-file-6b4e4280a076
@testable import SpaceX
import XCTest

class LaunchFetcherTests: XCTestCase {

    func testLoadsLaunchesFromJSONFile() throws {
        let fetcher = LaunchFetcher()
        let bundle = Bundle(for: type(of: self))
        let jsonURL = try XCTUnwrap(bundle.url(forResource: "past_launches", withExtension: "json"))

        let launches = fetcher.load(from: jsonURL)

        XCTAssertEqual(launches[0].name, "FalconSat")
        XCTAssertEqual(launches[1].name, "DemoSat")
        XCTAssertEqual(launches[2].name, "Trailblazer")
    }

    // This is the same test as above, but more Combine-y, I'd say. It tests the behavior of the
    // `@Published` value, rather than that of the return value.
    func testPublishesLaunchesFromJSONFile() throws {
        let fetcher = LaunchFetcher()
        let bundle = Bundle(for: type(of: self))
        let jsonURL = try XCTUnwrap(bundle.url(forResource: "past_launches", withExtension: "json"))

        fetcher.load(from: jsonURL)

        _ = fetcher.$launches.sink { launches in
            XCTAssertEqual(launches[0].name, "FalconSat")
            XCTAssertEqual(launches[1].name, "DemoSat")
            XCTAssertEqual(launches[2].name, "Trailblazer")
        }
    }
}
