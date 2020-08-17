import Combine
import XCTest

extension XCTestCase {

    func assertReceivesValue<T, E>(_ future: AnyPublisher<T, E>, onValue: @escaping (T) -> Void) {
        let expectation = XCTestExpectation()

        _ = future
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished: expectation.fulfill()
                    case .failure(let error):
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
                    XCTFail("Expected to fail, received value: \(value)")
                }
            )

        wait(for: [expectation], timeout: 0.1)
    }
}
