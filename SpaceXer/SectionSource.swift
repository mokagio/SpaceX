// Got the code to do the sections from here https://softauthor.com/swiftui-list-section-row/
struct SectionSource<T: Equatable>: Equatable, Identifiable {
    // let id = UUID()
    var id: String { title }
    let title: String
    let items: [T]
}
