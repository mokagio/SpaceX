import SwiftUI

struct ContentView: View {

    @ObservedObject var fetcher = LaunchFetcher()

    var body: some View {
        List {
            ForEach(groupLaunchesIntoSectionsByName(fetcher.launches)) { section in
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
