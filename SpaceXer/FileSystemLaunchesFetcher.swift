import Combine
import Foundation

class FileSystemLaunchesFetcher: NSObject, LaunchesFetching {

    private let url: URL

    init(url: URL = Bundle.main.url(forResource: "past_launches", withExtension: "json")!) {
        self.url = url
    }

    func fetch(group: @escaping ([Launch]) -> [SectionSource<Launch>]) -> AnyPublisher<[SectionSource<Launch>], Error> {
        // It's cool to compare this to the first versions of `LaunchFetcher`, this feels tidy
        // where that felt clumsy.
        return Result { try Data(contentsOf: url) }
            .flatMap { data in Result { try JSONDecoder().decode([Launch].self, from: data) } }
            .map { group($0) }
            .publisher
            .eraseToAnyPublisher()
    }
}
