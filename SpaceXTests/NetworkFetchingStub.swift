import Combine
import Foundation
@testable import SpaceX

class NetworkFetchingStub: NetworkFetching {

    private let result: Result<Data, URLError>

    // TODO: This ought to be some kind of mapping, like "return result for request with URL".
    init(returning result: Result<Data, URLError>) {
        self.result = result
    }

    func load(_ url: URL) -> AnyPublisher<Data, URLError> {
        load(URLRequest(url: url))
    }

    func load(_ request: URLRequest) -> AnyPublisher<Data, URLError> {
        return result.publisher.eraseToAnyPublisher()
    }
}
