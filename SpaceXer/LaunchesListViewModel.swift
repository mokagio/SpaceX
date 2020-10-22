extension LaunchesList {

    class ViewModel {

        typealias ViewForLaunchGetter = (Launch) -> LaunchDetail

        let sections: [SectionSource<Launch>]
        let getViewForLaunch: ViewForLaunchGetter

        init(sections: [SectionSource<Launch>], getViewForLaunch: @escaping ViewForLaunchGetter) {
            self.sections = sections
            self.getViewForLaunch = getViewForLaunch
        }
    }
}
