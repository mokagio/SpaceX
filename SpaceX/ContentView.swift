import Combine
import SwiftUI

struct ContentView: View {

    @ObservedObject var viewModel: LaunchesListViewModel

    var body: some View {
        switch viewModel.launches {
        case .notAsked, .loading:
            Text("Loading...")
        case .failure(let error):
            Text(error.localizedDescription)
        case .success(let launches):
            List {
                ForEach(groupLaunchesIntoSectionsByName(launches)) { section in
                    Section(header: Text(section.title)) {
                        ForEach(section.items) { item in
                            Text(item.name)
                        }
                    }
                }
            }
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: LaunchesListViewModel())
    }
}
#endif
