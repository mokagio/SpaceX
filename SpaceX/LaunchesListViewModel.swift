import Combine
import Foundation

class LaunchesListViewModel: ObservableObject {

    private let launchFetcher: LaunchFetcher
    private var bag = Set<AnyCancellable>()

    // TODO: Make a `RemoteData`
    @Published var launches: Result<[Launch], Error>?

    init(fetcher: LaunchFetcher = LaunchFetcher()) {
        launchFetcher = fetcher
    }

    // I'm not sure I like how this is bind to the API of SwiftUI.
    func onAppear() {
        launchFetcher.loadFromTheNet()
            // This delay is so that I can notice the loading when there's URLSession caching in place
            //.delay(for: .seconds(2), scheduler: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    guard case .failure(let error) = completion else { return print("Completed") }
                    self?.launches = .failure(error)
                },
                receiveValue: { [weak self] launches in
                    print("Got \(launches.count) results")
                    self?.launches = .success(launches)
                }
            )
            .store(in: &bag)
    }
}
