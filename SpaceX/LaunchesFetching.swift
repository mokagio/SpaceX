import Combine

protocol LaunchesFetching {

    func fetch() -> AnyPublisher<[Launch], Error>
}
