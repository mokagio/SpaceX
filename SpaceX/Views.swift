import Combine
import SwiftUI

// Since my views are still little, I'm trying this unusual approach (for me, at least) of having
// all the views in the same file.

struct LaunchesListContainer: View {

    @ObservedObject var viewModel: ViewModel

    var body: some View {
        NavigationView {
            contentView
                .navigationBarTitle("SpaceX Launches 🚀")
                // Interestingly, if I add this, the list view gets the grouped view style
                //.navigationBarItems(trailing: Button("test", action: {}))
        }
        .onAppear { viewModel.onAppear() }
    }

    // Without the `@ViewBuilder` we'd need to type erase the views returned from each of the
    // switch cases. Thanks Swift 5.3!
    @ViewBuilder private var contentView: some View {
        switch viewModel.launches {
        case .notAsked, .loading:
            Loading()
        case .failure(let error):
            ErrorView(error: error)
        case .success(let sections):
            LaunchesList(
                sections: sections,
                onSelect: { AnyView(LaunchDetail(launch: $0)) }
            )
        }
    }
}

struct Loading: View {

    var body: some View {
        Text("Loading...")
    }
}

// Can't call this `Error` because it would make the type inference go bonkers as it would look the
// same as `Swift.Error`.
struct ErrorView: View {

    let error: Error

    var body: some View {
        Text(error.localizedDescription)
    }
}

struct LaunchesList: View {

    let sections: [SectionSource<Launch>]
    let onSelect: (Launch) -> AnyView

    var body: some View {
        List {
            ForEach(sections) { section in
                Section(header: Text(section.title)) {
                    ForEach(section.items) { item in
                        NavigationLink(destination: onSelect(item)) {
                            LaunchRow(launch: item)
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

    @Published private(set) var onLaunchSelectedFromList: (Launch) -> AnyView = { AnyView(LaunchDetail(launch: $0)) }
}

// swiftlint:disable:next type_name
struct _LaunchesList: View {

    let sections: [SectionSource<Launch>]
    @EnvironmentObject var router: Router

    var body: some View {
        List {
            ForEach(sections) { section in
                Section(header: Text(section.title)) {
                    ForEach(section.items) { item in
                        NavigationLink(destination: router.onLaunchSelectedFromList(item)) {
                            LaunchRow(launch: item)
                        }
                    }
                }
            }
        }
    }
}

struct LaunchRow: View {

    let launch: Launch

    var body: some View {
        Text(launch.name)
    }
}

struct LaunchDetail: View {

    struct ViewModel {
        let name: String
        let timeSinceLaunch: String
    }

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

extension LaunchDetail.ViewModel {

    static func from(_ launch: Launch, date: Date = Date()) -> Self {
        LaunchDetail.ViewModel(
            name: launch.name,
            timeSinceLaunch: "\(date.timeIntervalSince(launch.date).rounded().toInt())"
        )
    }
}

#if DEBUG
struct LaunchesListContainerView_Previews: PreviewProvider {
    static var previews: some View {
        Text("I'll work on previews later")
    }
}
#endif

extension TimeInterval {

    func toInt() -> Int {
        Int(self)
    }
}
