import Foundation

struct Launch: Equatable, Decodable, Hashable, Identifiable {
    let id: String
    let name: String
    let dateUnix: Int
    let success: Bool

    enum CodingKeys: String, CodingKey {
        case id, name, success
        case dateUnix = "date_unix"
    }

    var formattedName: String { "\(name) 🚀" }

    var date: Date { Date(timeIntervalSince1970: TimeInterval(dateUnix)) }
}
