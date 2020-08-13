import Combine
@testable import SpaceX
import XCTest

class NetworkFetchingTests: XCTestCase {

    func testLoadingDecodableWhenRequestSucceedsReturnsDecodedValue() throws {
        // Note that we're using `NetworkFetchingStub` because `NetworkFetching` is a protocol and
        // the behavior we're testing is defined in a protocol extension.
        let networkFetcher = try XCTUnwrap(
            NetworkFetchingStub(returningJSON: #"{ "string": "value", "int": 1 }"#)
        )

        let publisher: AnyPublisher<DummyDecodable, Error> = networkFetcher.load(URL(string: "http://test.com")!)

        assertReceivesValue(publisher) { value in
            XCTAssertEqual(value.string, "value")
            XCTAssertEqual(value.int, 1)
        }
    }

    func testLoadingDecodableWhenRequestFailsPropagatesError() throws {
        // Note that we're using `NetworkFetchingStub` because `NetworkFetching` is a protocol and
        // the behavior we're testing is defined in a protocol extension.
        let networkFetcher = try XCTUnwrap(NetworkFetchingStub(returning: .failure(URLError(.badURL))))

        let publisher: AnyPublisher<DummyDecodable, Error> = networkFetcher.load(URL(string: "http://test.com")!)

        assertReceivesFailure(publisher) { error in
            XCTAssertEqual(error as? URLError, URLError(.badURL))
        }
    }

    private struct DummyDecodable: Decodable {
        let string: String
        let int: Int
    }
}
