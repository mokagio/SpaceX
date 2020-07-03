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
        let jsonURL = try XCTUnwrap(Bundle(for: type(of: self)).url(forResource: "past_launches", withExtension: "json"))

        let launches = fetcher.load(from: jsonURL)

        XCTAssertEqual(launches[0].name, "FalconSat")
        XCTAssertEqual(launches[1].name, "DemoSat")
        XCTAssertEqual(launches[2].name, "Trailblazer")
    }
}

struct LaunchFetcher {

    func load(from url: URL) -> [Launch] {
        do {
            let jsonData = try Data(contentsOf: url)
            return try JSONDecoder().decode([Launch].self, from: jsonData)
        } catch {
            // TODO: feels like we should use a `Result` here
            return []
        }
    }
}
