import Foundation

struct LaunchFetcher {

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
