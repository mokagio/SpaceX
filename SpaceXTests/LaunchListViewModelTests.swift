import Combine
@testable import SpaceX
import XCTest

class LaunchListViewModelTests: XCTestCase {

    var bag = Set<AnyCancellable>()

    func testOnAppearSuccessfulPathStreamsExpectedStates() throws {
        var states: [RemoteData<[Launch], Error>] = []
        let viewModel = LaunchesListViewModel(
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
}

class LaunchesFetchingStub: LaunchesFetching {

    private let result: Result<[Launch], Error>

    init(result: Result<[Launch], Error>) {
        self.result = result
    }

    func fetch() -> AnyPublisher<[Launch], Error> {
        return result.publisher.eraseToAnyPublisher()
    }
}
