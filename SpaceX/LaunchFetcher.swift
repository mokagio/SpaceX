import Foundation

class LaunchFetcher: ObservableObject {

    @Published var launches: [Launch] = []

    init() {}

    @discardableResult
    func load(from url: URL) -> [Launch] {
        do {
            let jsonData = try Data(contentsOf: url)
            launches = try JSONDecoder().decode([Launch].self, from: jsonData)
            return launches
        } catch {
            // TODO: feels like we should use a `Result` here
            return []
        }
    }
}
