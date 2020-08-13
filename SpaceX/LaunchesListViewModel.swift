import Combine
import Foundation

class LaunchesListViewModel: ObservableObject {

    private let launchFetcher: LaunchesFetching
    private var bag = Set<AnyCancellable>()

    @Published var launches: RemoteData<[Launch], Error> = .notAsked

    init(fetcher: LaunchesFetching = LaunchFetcher()) {
        launchFetcher = fetcher
    }

    // I'm not sure I like how this is bound to the API of SwiftUI.
    func onAppear() {
        launches = .loading

        launchFetcher.fetch()
            // This delay is so that I can notice the loading when there's URLSession caching in place
            //.delay(for: .seconds(2), scheduler: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    guard case .failure(let error) = completion else { return }
                    self?.launches = .failure(error)
                },
                receiveValue: { [weak self] launches in
                    self?.launches = .success(launches)
                }
            )
            .store(in: &bag)
    }
}
