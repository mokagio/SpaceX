@testable import SpaceX
import XCTest

class LaunchTests: XCTestCase {

    func testLaunchJSONDecoding() throws {
        let jsonURL = try XCTUnwrap(Bundle(for: type(of: self)).url(forResource: "past_launches", withExtension: "json"))
        let jsonData = try Data(contentsOf: jsonURL)
        let launches = try JSONDecoder().decode([Launch].self, from: jsonData)
        let launch = try XCTUnwrap(launches.first)
        XCTAssertEqual(launch.name, "FalconSat")
    }

    // This is just a silly test to play around with the best way to deal with Decodable types in
    // the test suite.
    //
    // The fact is that I don't want production code to be able to `init` a `Decodable` type using
    // the compiler provide initializer, because this kind of types should only come from the
    // network. (This is a rule worth questioning, though. Does it really matter? What difference
    // does it make if you can or cannot init those types directly? From the design point of view,
    // does it make sense to define `Decodable` as part of the type definition instead than an
    // extension?)
    //
    // Update: I was surprised that the tests passed immediately, or rather that the code compiled.
    // I'm guessing something has changed in the Swift compiler since I last did this kind of
    // things.
    func testLaunchNameFormatting() {
        let launch = Launch(name: "test")

        XCTAssertEqual(launch.formattedName, "test 🚀")
    }
}
