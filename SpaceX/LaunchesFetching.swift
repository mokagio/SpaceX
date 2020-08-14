import Combine

protocol LaunchesFetching {

    // Originally I had this signature:
    //
    // func fetch() -> AnyPublisher<[Launch], Error>
    //
    // But when it came time to move the logic to group the launches into sections away from the
    // view in order to test it got actually called, I decided to move it here.
    //
    // The other option I considered was to make `LaunchesListViewModel` do the grouping. While that
    // seemed appropriate, because how the data is grouped in the view layer is something that
    // concerns only the view layer, writing the test for the behavior at the level of
    // `LaunchesListViewModel` with all its streaming of view states would have been harder than
    // writing it at the level of a type conforming to `LaunchesFetching`, where there the publisher
    // sends the value and then completes.
    //
    // I'm not totally convinced of this approach, yet. The only way to find out, though, is to take
    // it for a ride.
    func fetch() -> AnyPublisher<[SectionSource<Launch>], Error>
}
