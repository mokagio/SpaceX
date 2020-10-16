import Combine
import Foundation
import SwiftUI

extension LaunchesListContainer {

    class ViewModel: ObservableObject {

        typealias LaunchDetailGetter = (Launch) -> LaunchDetail

        private let launchFetcher: LaunchesFetching
        private var cancellables = Set<AnyCancellable>()

        private let launchDetailGetter: LaunchDetailGetter
        // Or?
        // private let getLaunchDetailForLaunch: LaunchDetailGetter

        @Published var launches: RemoteData<[SectionSource<Launch>], Error> = .notAsked

        init(
            launchDetailGetter: @escaping LaunchDetailGetter,
            fetcher: LaunchesFetching = LaunchFetcher()
        ) {
            launchFetcher = fetcher
            self.launchDetailGetter = launchDetailGetter
        }

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
                .store(in: &cancellables)
        }

        func launchesList(for sections: [SectionSource<Launch>]) -> LaunchesList {
           return LaunchesList(
                viewModel: .init(sections: sections, getViewForLaunch: launchDetailGetter)
           )
        }
    }
}
