import Combine
import XCTest

extension XCTestCase {
    func assert<T, E>(_ future: Future<T, E>, receivesValue onValue: @escaping (T) -> Void) {
        let expectation = XCTestExpectation()

        _ = future
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished: expectation.fulfill()
                    case .failure(let error): XCTFail(error.localizedDescription)
                    }
                },
                receiveValue: { onValue($0) }
            )

        wait(for: [expectation], timeout: 0.1)
    }

    func assertReceivesValue<T, E>(_ future: AnyPublisher<T, E>, onValue: @escaping (T) -> Void) {
        let expectation = XCTestExpectation()

        _ = future
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished: expectation.fulfill()
                    case .failure(let error):
                        // TODO: this failure is not reported inline, nor by the new Xcode 12 drill
                        // into error grey reporter
                        XCTFail("Expected to receive value, failed with: \(error.localizedDescription)")
                    }
                },
                receiveValue: { onValue($0) }
            )

        wait(for: [expectation], timeout: 0.1)
    }

    func assertReceivesFailure<T, E>(_ future: AnyPublisher<T, E>, onFailure: @escaping (E) -> Void) {
        let expectation = XCTestExpectation()

        _ = future
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        expectation.fulfill()
                    case .failure(let error):
                        onFailure(error)
                        expectation.fulfill()
                    }
                },
                receiveValue: { value in
                    // TODO: this failure is not reported inline, nor by the new Xcode 12 drill
                    // into error grey reporter
                    XCTFail("Expected to fail, received value: \(value)")
                }
            )

        wait(for: [expectation], timeout: 0.1)
    }
}
