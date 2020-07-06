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

    func load(from url: URL) -> Future<[Launch], LaunchFetcherError> {
        return Future { [unowned self] promise in
            promise(self.load(from: url))
        }
    }
}
