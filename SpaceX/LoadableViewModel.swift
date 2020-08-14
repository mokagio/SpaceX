import Combine

// I thought this was a good idea, but then I couldn't use it as an `@ObservedObeject` in a `View`
// because it depends on `Self`.
//
// I might have more luck with a concrete class, along the lines of `RemoteDataViewModel<Resource>`,
// but this is not the time to work on abstractions that I don't know if I'll need. YAGNI!

protocol LoadableViewModel {

    associatedtype Resource where Resource: Equatable

    var publishedResource: Published<RemoteData<Resource, Error>>.Publisher { get }
}

extension LaunchesListViewModel: LoadableViewModel {

    typealias Resource = [SectionSource<Launch>]

    var publishedResource: Published<RemoteData<Resource, Error>>.Publisher { $launches }
}
