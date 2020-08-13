import Combine
import Foundation

class NetworkService: NetworkFetching {

    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func load(_ request: URLRequest) -> AnyPublisher<Data, URLError> {
        return session
            .dataTaskPublisher(for: request)
            .map { $0.data }
            .eraseToAnyPublisher()
    }
}
