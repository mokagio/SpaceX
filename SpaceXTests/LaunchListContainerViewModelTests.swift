import Combine
@testable import SpaceX
import XCTest

class LaunchListViewModelTests: XCTestCase {

    var bag = Set<AnyCancellable>()

    func testOnAppearSuccessfulPathStreamsExpectedStates() throws {
        var states: [RemoteData<[SectionSource<Launch>], Error>] = []
        let viewModel = LaunchesListContainer.ViewModel(
            launchDetailGetter: {
                LaunchDetail(viewModel: .init(launch: $0, favoritesController: FavoritesController()))
            },
            fetcher: LaunchesFetchingStub(
                result: .success([.fixture(), .fixture()])
            )
        )

        let expectation = XCTestExpectation(description: "")

        viewModel.$launches
            .sink(
                receiveCompletion: { _ in
                    expectation.fulfill()
                },
                receiveValue: { value in
                    states.append(value)
                    if case .success = value { expectation.fulfill() }
                }
            )
            .store(in: &bag)

        viewModel.onAppear()

        wait(for: [expectation], timeout: 0.1)

        XCTAssertEqual(states.count, 3)
        XCTAssertEqual(states[safe: 0], .notAsked)
        XCTAssertEqual(states[safe: 1], .loading)
        let value = try XCTUnwrap(states[safe: 2])
        guard case .success = value else { return XCTFail("Expected value to be a .success") }
    }

    func testOnAppearFailurePathStreamsExpectedStates() throws {
        var states: [RemoteData<[SectionSource<Launch>], Error>] = []
        let viewModel = LaunchesListContainer.ViewModel(
            launchDetailGetter: {
                LaunchDetail(viewModel: .init(launch: $0, favoritesController: FavoritesController()))
            },
            fetcher: LaunchesFetchingStub(
                result: .failure(URLError(.fileDoesNotExist))
            )
        )

        let expectation = XCTestExpectation(description: "")

        viewModel.$launches
            .sink(
                receiveCompletion: { _ in
                    expectation.fulfill()
                },
                receiveValue: { value in
                    states.append(value)
                    if case .failure = value { expectation.fulfill() }
                }
            )
            .store(in: &bag)

        viewModel.onAppear()

        wait(for: [expectation], timeout: 0.1)

        XCTAssertEqual(states.count, 3)
        XCTAssertEqual(states[safe: 0], .notAsked)
        XCTAssertEqual(states[safe: 1], .loading)
        let value = try XCTUnwrap(states[safe: 2])
        guard case .failure(let error) = value else { return XCTFail("Expected value to be a .failure") }
        XCTAssertEqual(error as? URLError, URLError(.fileDoesNotExist))
    }
}

class LaunchesFetchingStub: LaunchesFetching {

    private let result: Result<[SectionSource<Launch>], Error>

    init(result: Result<[SectionSource<Launch>], Error>) {
        self.result = result
    }

    func fetch(
        group: @escaping ([Launch]) -> [SectionSource<Launch>]
    ) -> AnyPublisher<[SectionSource<Launch>], Error> {
        return result.publisher.eraseToAnyPublisher()
    }
}

extension SectionSource where T == Launch {

    static func fixture(
        title: String = "title",
        items: [Launch] = [.fixture()]
    ) -> SectionSource<Launch> {
        return SectionSource(title: title, items: items)
    }
}
