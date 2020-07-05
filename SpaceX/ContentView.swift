import SwiftUI

struct ContentView: View {

    // Got the code to do the sections from here https://softauthor.com/swiftui-list-section-row/
    struct SectionSource<T>: Identifiable {
        let id = UUID()
        let title: String
        let items: [T]
    }

    @ObservedObject var fetcher = LaunchFetcher()

    var body: some View {
        List {
            ForEach(
                [
                    SectionSource(title: "a", items: fetcher.launches),
                    SectionSource(title: "b", items: fetcher.launches)
                ]
            ) { section in
                Section(header: Text(section.title)) {
                    ForEach(section.items) { item in
                        Text(item.name)
                    }
                }
            }
        }
        .onAppear {
            guard let url = Bundle.main.url(forResource: "past_launches", withExtension: "json") else { return }
            fetcher.load(from: url)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
