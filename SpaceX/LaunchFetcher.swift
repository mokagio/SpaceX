import Combine
import Foundation

class LaunchFetcher: ObservableObject {

    enum LaunchFetcherError: Error {
        case couldNotLoadURL
        case couldNotDecode
    }

    @Published var launches: [Launch] = []

    init() {}

    @discardableResult
    func load(from url: URL) -> [Launch] {
        let result: Result<[Launch], LaunchFetcherError> = load(from: url)
        switch result {
        case .success(let launches):
            self.launches = launches
            return launches
        case .failure:
            return []
        }
    }

    private func load(from url: URL) -> Result<[Launch], LaunchFetcherError> {
        return Result { try Data(contentsOf: url) }
            .mapError { _ in return LaunchFetcherError.couldNotLoadURL }
            .flatMap { data in Result { try JSONDecoder().decode([Launch].self, from: data) } }
            .mapError { _ in return LaunchFetcherError.couldNotLoadURL }
    }
}
