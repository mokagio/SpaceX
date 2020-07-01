struct Launch: Decodable {
    let name: String

    var formattedName: String { "\(name) 🚀" }
}
