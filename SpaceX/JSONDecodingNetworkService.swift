import Combine
import Foundation

class JSONDecodingNetworkService {

    private let jsonDecoder = JSONDecoder()
    private let networkFetcher: NetworkFetching

    init(session: URLSession = .shared) {
        networkFetcher = NetworkService(session: session)
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
