import Combine
import Foundation

// What I think is the neat thing about abstracting the basic networking interface behind a protocol
// is that we don't even have to create a new object to conform to it unless we have to; we can
// simply make `URLSession` conform to the protocol.
//
// Admittedly, this bit of code is not tested, because it goes off and hits the real world network.
// I think that's okay in that there is no custom logic here; we are only calling `Foundation` and
// `Combine` APIs.
//
// If I wanted to go overboard and test this bit, too, I'd do it in a dedicated test target, where
// I'd either put in place a fake endpoint which I can control, or use the OHHTTPStubs library to
// stub the network responses.
extension URLSession: NetworkFetching {

    func load(_ request: URLRequest) -> AnyPublisher<Data, URLError> {
        return dataTaskPublisher(for: request)
            .map { $0.data }
            .eraseToAnyPublisher()
    }
}

extension URLSession: LaunchesFetching {
    func fetch() -> AnyPublisher<[SectionSource<Launch>], Error> {
        return load(URL(string: "https://api.spacexdata.com/v4/launches/past")!)
            .map { groupLaunchesIntoSectionsByName($0) }
            .eraseToAnyPublisher()
    }
}
