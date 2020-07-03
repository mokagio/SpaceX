struct Launch: Decodable, Identifiable {
    let id: String
    let name: String

    var formattedName: String { "\(name) 🚀" }
}
