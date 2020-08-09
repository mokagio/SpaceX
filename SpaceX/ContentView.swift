import Combine
import SwiftUI

class LaunchViewModel: ObservableObject {

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
            .delay(for: .seconds(2), scheduler: DispatchQueue.global(qos: .background))
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

struct DummyView: View {

    var body: some View {
        Text("...")
    }
}

struct ContentView: View {

    @ObservedObject var viewModel: LaunchViewModel

    var body: some View {
        switch viewModel.launches {
        case .none: Text("Loading...")
        case .some(let result):
            switch result {
            case .success(let launches):
                List {
                    ForEach(groupLaunchesIntoSectionsByName(launches)) { section in
                        Section(header: Text(section.title)) {
                            ForEach(section.items) { item in
                                Text(item.name)
                            }
                        }
                    }
                }
            case .failure(let error):
                Text(error.localizedDescription)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: LaunchViewModel())
    }
}
