import Combine
import Foundation

// Needs to be `NSObject` in order to conform to `UITableViewDataSource`, which looking at it from
// here looks pretty wrong, actually... See my other comment in
// `LaunchFetcher+UITableViewDataSource.swift`.
class LaunchFetcher: NSObject, ObservableObject {

    enum LaunchFetcherError: Error {
        case couldNotLoadURL
        case couldNotDecode
    }

    private let networkService: NetworkFetching

    init(networkService: NetworkFetching = URLSession.shared) {
        self.networkService = networkService
    }

    @Published var launches: [Launch] = []

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

extension LaunchFetcher: LaunchesFetching {

    func fetch(group: @escaping ([Launch]) -> [SectionSource<Launch>]) -> AnyPublisher<[SectionSource<Launch>], Error> {
        return networkService
            .load(URL(string: "https://api.spacexdata.com/v4/launches/past")!)
            .map { group($0) }
            .eraseToAnyPublisher()
    }
}
