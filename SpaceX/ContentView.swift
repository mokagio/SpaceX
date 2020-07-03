import SwiftUI

struct ContentView: View {

    @ObservedObject var fetcher = LaunchFetcher()

    var body: some View {
        List(fetcher.launches) { launch in
            Text(launch.name)
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
