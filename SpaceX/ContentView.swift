import Combine
import SwiftUI

// Since my views are still little, I'm trying this unusual approach (for me at least) of having
// all the views in the same file.

struct ContentView: View {

    @ObservedObject var viewModel: LaunchesListViewModel

    var body: some View {
        switch viewModel.launches {
        case .notAsked, .loading:
            LoadingView()
        case .failure(let error):
            ErrorView(error: error)
        case .success(let launches):
            LaunchesListView(launches: launches)
        }
    }
}

struct LoadingView: View {

    var body: some View {
        Text("Loading...")
    }
}

struct ErrorView: View {

    let error: Error

    var body: some View {
        Text(error.localizedDescription)
    }
}

struct LaunchesListView: View {

    let launches: [Launch]

    var body: some View {
        List {
            ForEach(groupLaunchesIntoSectionsByName(launches)) { section in
                Section(header: Text(section.title)) {
                    ForEach(section.items) { item in
                        LaunchCellView(launch: item)
                    }
                }
            }
        }
    }
}

struct LaunchCellView: View {

    let launch: Launch

    var body: some View {
        Text(launch.name)
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: LaunchesListViewModel())
    }
}
#endif
