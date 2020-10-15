import SwiftUI

struct FavoritesList: View {

    @ObservedObject var viewModel: ViewModel

    var body: some View {
        List(viewModel.launches) { item in
            LaunchRow(launch: item)
        }
    }
}
