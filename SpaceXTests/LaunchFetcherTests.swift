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

        let launches: [Launch] = fetcher.load(from: jsonURL)

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

        let _: [Launch] = fetcher.load(from: jsonURL)

        _ = fetcher.$launches.sink { launches in
            XCTAssertEqual(launches[0].name, "FalconSat")
            XCTAssertEqual(launches[1].name, "DemoSat")
            XCTAssertEqual(launches[2].name, "Trailblazer")
        }
    }

    // MARK: -

    // The idea behind this test is that since the grouping has edge cases and is already tested in
    // isolation in it's own function, and given testing loading data from the network is complex
    // because we need to setup stubs and everything, just tell the fetcher to use a function to
    // do the grouping and trust that a default value will be set that uses the desired one.
    //
    // I'm a bit uneasy about the "trust that" part, but at the same time, it's such a silly bit of
    // code... is it really worth the extra test when the rest of the setup is tightly tested?
    // An extra test, by the way, which would be more at the integration level than anything else.
    //
    // Another way to look at it. If we looked at it from the point of view of how many tests need
    // to change if we want to change the grouping behavior? The would be the integration style
    // test here and the test for the new or modified behavior.
    func testLoadingFromNetworkWhenResponseSucceedsReturnsDataGroupedWithGivenFunc() throws {
        let stub = try XCTUnwrap(
            NetworkFetchingStub(
                returningJSON: launchesJSONFixture(with: [launchJSON(), launchJSON(), launchJSON()])
            )
        )
        let fetcher = LaunchFetcher(networkService: stub)

        var called = false
        let group: ([Launch]) -> [SectionSource<Launch>] = {
            called = true
            return [SectionSource(title: "test", items: $0)]
        }

        assertReceivesValue(fetcher.fetch(group: group)) { sections in
            XCTAssertEqual(sections.count, 1)
            XCTAssertEqual(sections[safe: 0]?.title, "test")
        }

        // This is a bit redundant, or rather I just want to be sure the success above is not a
        // false positive, so I'm triangulating.
        XCTAssertTrue(called)
    }

    // This is the integration style test mentioned just above, I'm leaving it here for reference.
    func testLoadingFromNetworkWhenResponseSucceedsReturnsDataGroupedByYear() throws {
        let stub = try XCTUnwrap(
            NetworkFetchingStub(
                returningJSON: launchesJSONFixture(
                    with: [
                        launchJSON(name: "first", dateUnix: Int(Date(year: 2019).timeIntervalSince1970)),
                        launchJSON(name: "third", dateUnix: Int(Date(year: 2020).timeIntervalSince1970)),
                        launchJSON(name: "second", dateUnix: Int(Date(year: 2019).timeIntervalSince1970))
                    ]
                )
            )
        )
        let fetcher = LaunchFetcher(networkService: stub)

        assertReceivesValue(fetcher.fetch()) { sections in
            XCTAssertEqual(sections.count, 2)
            // Cannot `try XCTUnwrap` because this code runs within a `sink` and it cannot `throw`
            let first = sections[safe: 0]
            XCTAssertEqual(first?.title, "2019")
            XCTAssertEqual(first?.items[safe: 0]?.name, "first")
            XCTAssertEqual(first?.items[safe: 1]?.name, "second")
            let second = sections[safe: 1]
            XCTAssertEqual(second?.title, "2020")
            XCTAssertEqual(second?.items[safe: 0]?.name, "third")
        }
    }

    func testLoadingFromNetworkWhenResponseFailsPropagatesError() throws {
        let stub = try XCTUnwrap(NetworkFetchingStub(returning: .failure(URLError(.badURL))))
        let fetcher = LaunchFetcher(networkService: stub)

        assertReceivesFailure(fetcher.fetch()) { error in
            XCTAssertEqual(error as? URLError, URLError(.badURL))
        }
    }
}
