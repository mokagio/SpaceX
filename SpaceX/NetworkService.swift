import Combine
import Foundation

class NetworkService {

    private let session: URLSession
    private let jsonDecoder = JSONDecoder()

    init(session: URLSession = .shared) {
        self.session = session
    }

    func load<T: Decodable>(_ url: URL) -> AnyPublisher<T, Error> {
        return load(URLRequest(url: url))
    }

    func load<T: Decodable>(_ request: URLRequest) -> AnyPublisher<T, Error> {
        return session.dataTaskPublisher(for: request)
            // This is missing out on possibly important information in the response.
            // I can see this evolving into a more refined method that passes along info from the
            // response if needed
            .map { $0.data }
            .decode(type: T.self, decoder: jsonDecoder)
            .eraseToAnyPublisher()
    }
}
