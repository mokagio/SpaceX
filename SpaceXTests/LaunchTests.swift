import XCTest

class LaunchTests: XCTestCase {

    func testLaunchJSONDecoding() throws {
        let jsonURL = try XCTUnwrap(Bundle(for: type(of: self)).url(forResource: "past_launches", withExtension: "json"))
        let jsonData = try Data(contentsOf: jsonURL)
        let launches = try JSONDecoder().decode([Launch].self, from: jsonData)
        let launch = try XCTUnwrap(launches.first)
        XCTAssertEqual(launch.name, "FalconSat")
    }

    struct Launch: Decodable {
        let name: String
    }
}
