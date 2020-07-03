import Foundation

class LaunchFetcher: ObservableObject {

    @Published var launches: [Launch] = []

    init() {}

    func load(from url: URL) -> [Launch] {
        do {
            let jsonData = try Data(contentsOf: url)
            return try JSONDecoder().decode([Launch].self, from: jsonData)
        } catch {
            // TODO: feels like we should use a `Result` here
            return []
        }
    }
}
