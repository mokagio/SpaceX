@testable import SpaceXer
import XCTest

class LaunchTests: XCTestCase {

    func testLaunchJSONDecoding() throws {
        let bundle = Bundle(for: type(of: self))
        let jsonURL = try XCTUnwrap(bundle.url(forResource: "past_launches", withExtension: "json"))
        let jsonData = try Data(contentsOf: jsonURL)
        let launches = try JSONDecoder().decode([Launch].self, from: jsonData)

        let launch = try XCTUnwrap(launches.first)

        XCTAssertEqual(launch.id, "5eb87cd9ffd86e000604b32a")
        XCTAssertEqual(launch.name, "FalconSat")
    }

    func testLaunchJSONDecodingDifferentFixture() throws {
        let json = launchJSON(name: "test-name", id: "abc123", dateUnix: 12345)
        let jsonData = try XCTUnwrap(json.data(using: .utf8))
        let launch = try JSONDecoder().decode(Launch.self, from: jsonData)

        XCTAssertEqual(launch.id, "abc123")
        XCTAssertEqual(launch.name, "test-name")
        XCTAssertEqual(launch.dateUnix, 12345)
    }

    func testLaunchComputedDate() {
        let launch = Launch.fixture(dateUnix: 1234567)

        XCTAssertEqual(launch.date, Date(timeIntervalSince1970: 1234567))
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
        // Using the fixture here makes clear that the only value which matters for this behavior
        // is the name.
        let launch = Launch.fixture(name: "test")

        XCTAssertEqual(launch.formattedName, "test 🚀")
    }
}

extension Launch {

    // Here's one reason why we can't just write fixtures with a custom init, it would end up
    // overriding the compiler generated one and either require extra manual work on our side, by
    // reimplementing what the compiler already offers, or result in a code path that keeps calling
    // itself.
//    init(id: String = "abc", name: String = "test") {
//        self.init(id: id, name: name)
//    }
    //
    // One alternative could be to use an init with a different name, but at that point, which name
    // would you choose?
    //
    // This is why I think using fixtures is better. It doesn't mess up with the init definition,
    // and also makes it clear that what we're using is an initializer that uses default values.
    static func fixture(
        id: String = "abc123",
        name: String = "launch-name",
        dateUnix: Int = 123456,
        success: Bool = true
    ) -> Launch {
        return Launch(id: id, name: name, dateUnix: dateUnix, success: success)
    }

    static func fixture(
        id: String,
        date: Date,
        success: Bool = true
    ) -> Launch {
        return Launch(id: id, name: "name", dateUnix: Int(date.timeIntervalSince1970), success: success)
    }
}
