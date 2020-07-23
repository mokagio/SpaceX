import Foundation

struct Launch: Equatable, Decodable, Identifiable {
    let id: String
    let name: String
    let dateUnix: Int

    enum CodingKeys: String, CodingKey {
        case id, name
        case dateUnix = "date_unix"
    }

    var formattedName: String { "\(name) 🚀" }

    var date: Date { Date(timeIntervalSince1970: TimeInterval(dateUnix)) }
}
