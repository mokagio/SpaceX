import Combine
import SwiftUI

// Since my views are still little, I'm trying this unusual approach (for me at least) of having
// all the views in the same file.

struct LaunchesListContainerView: View {

    @ObservedObject var viewModel: LaunchesListViewModel

    var body: some View {
        NavigationView {
            contentView
                .navigationBarTitle("SpaceX Launches 🚀")
                // Interestingly, if I add this, the list view gets the grouped view style
                //.navigationBarItems(trailing: Button("test", action: {}))
        }
    }

    // Without the `@ViewBuilder` we'd need to type erase the views returned from each of the
    // switch cases. Thanks Swift 5.3!
    @ViewBuilder private var contentView: some View {
        switch viewModel.launches {
        case .notAsked, .loading:
            LoadingView()
        case .failure(let error):
            ErrorView(error: error)
        case .success(let sections):
            LaunchesListView(
                sections: sections,
                onSelect: { AnyView(LaunchView(launch: $0)) }
            )
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

    let sections: [SectionSource<Launch>]
    let onSelect: (Launch) -> AnyView

    var body: some View {
        List {
            ForEach(sections) { section in
                Section(header: Text(section.title)) {
                    ForEach(section.items) { item in
                        NavigationLink(destination: onSelect(item)) {
                            LaunchCellView(launch: item)
                        }
                    }
                }
            }
        }
    }
}

// Here's a different version of the above, where instead of DI-ing the closure to compute the view
// to show on selection.
//
// To use it, some view higher up in the hierarchy `.environmentObject(Router())` needs to be
// called.
class Router: ObservableObject {

    @Published private(set) var onLaunchSelectedFromList: (Launch) -> AnyView = { AnyView(LaunchView(launch: $0)) }
}

// swiftlint:disable:next type_name
struct _LaunchesListView: View {

    let sections: [SectionSource<Launch>]
    @EnvironmentObject var router: Router

    var body: some View {
        List {
            ForEach(sections) { section in
                Section(header: Text(section.title)) {
                    ForEach(section.items) { item in
                        NavigationLink(destination: router.onLaunchSelectedFromList(item)) {
                            LaunchCellView(launch: item)
                        }
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

struct LaunchView: View {

    let launch: Launch

    // The commented code is to help me figure out some layout behavior
    var body: some View {
        ZStack {
//            Color.yellow
            VStack {
                Text(launch.name).bold()
                Text("\(Date().timeIntervalSince(launch.date))")
                Spacer()
            }
//            .background(Color.green)
//            .border(Color.red)
        }
    }
}

#if DEBUG
struct LaunchesListContainerView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchesListContainerView(viewModel: LaunchesListViewModel())
    }
}
#endif
