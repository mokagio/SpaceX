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

    // Could call this `testPublishesLaunchesFromJSONFile`.
    //
    // It does take quite a bit of boilerplate code to test a `Future` (and I assume the same
    // applies to `Publisher`, too). I wonder if there's some sugar already available?
    func testLoadWithFutureImplementation() throws {
        let fetcher = LaunchFetcher()
        let bundle = Bundle(for: type(of: self))
        let jsonURL = try XCTUnwrap(bundle.url(forResource: "past_launches", withExtension: "json"))

        let expectation = XCTestExpectation(description: "loads and parses JSON from given local URL")
        _ = fetcher.load(from: jsonURL)
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished: expectation.fulfill()
                    case .failure(let error): XCTFail(error.localizedDescription)
                    }
                },
                receiveValue: { launches in
                    XCTAssertEqual(launches[0].name, "FalconSat")
                    XCTAssertEqual(launches[1].name, "DemoSat")
                    XCTAssertEqual(launches[2].name, "Trailblazer")
                }
            )

        wait(for: [expectation], timeout: 0.1)
    }

    func testLoadWithFutureImplementationWithSyntaxSugar() throws {
        let fetcher = LaunchFetcher()
        let bundle = Bundle(for: type(of: self))
        let jsonURL = try XCTUnwrap(bundle.url(forResource: "past_launches", withExtension: "json"))

        assert(fetcher.load(from: jsonURL)) { launches in
            XCTAssertEqual(launches[0].name, "FalconSat")
            XCTAssertEqual(launches[1].name, "DemoSat")
            XCTAssertEqual(launches[2].name, "Trailblazer")
        }
    }
}

import Combine

extension XCTestCase {
    func assert<T, E>(_ future: Future<T, E>, receivesValue onValue: @escaping (T) -> Void) {
        let expectation = XCTestExpectation()

        _ = future
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished: expectation.fulfill()
                    case .failure(let error): XCTFail(error.localizedDescription)
                    }
                },
                receiveValue: { onValue($0) }
            )

        wait(for: [expectation], timeout: 0.1)
    }
}
