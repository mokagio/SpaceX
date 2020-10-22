@testable import SpaceXer
import XCTest

class CollectionSafeAccessTests: XCTestCase {

    func testAccessInBoundsReturnsValue() {
        XCTAssertEqual([1, 2, 3][safe: 0], 1)
        XCTAssertEqual([1, 2, 3][safe: 2], 3)
    }

    func testOutOfBoundAccessReturnsNil() {
        XCTAssertNil([1, 2, 3][safe: 3])
        XCTAssertNil([1, 2, 3][safe: -1])
    }
}
