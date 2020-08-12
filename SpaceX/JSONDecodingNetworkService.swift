import Combine
import Foundation

// I don't like how this class has a nested `NetworkService`, I'd like to be able to compose the
// functionality without having an extra object in between.
class JSONDecodingNetworkService {

    private let jsonDecoder = JSONDecoder()
    private let networkFetcher: NetworkFetching

    init(networkFetcher: NetworkFetching) {
        self.networkFetcher = networkFetcher
    }

    func load<T: Decodable>(_ url: URL) -> AnyPublisher<T, Error> {
        return load(URLRequest(url: url))
    }

    func load<T: Decodable>(_ request: URLRequest) -> AnyPublisher<T, Error> {
        return networkFetcher
            .load(request)
            .decode(type: T.self, decoder: jsonDecoder)
            .eraseToAnyPublisher()
    }
}
