@testable import SpaceX
import XCTest

class LaunchFetcherUITableViewDataSourceTests: XCTestCase {

    func testDataSourceNumberOfRows() throws {
        let fetcher = try XCTUnwrap(getFetcherAndLoad())
        let tableView = UITableView()
        fetcher.bind(to: tableView)

        XCTAssertEqual(
            fetcher.tableView(tableView, numberOfRowsInSection: 0),
            fetcher.launches.count
        )
    }

    func testDataSourceCellForRowAtIndex() throws {
        let fetcher = try XCTUnwrap(getFetcherAndLoad())
        let tableView = UITableView()
        fetcher.bind(to: tableView)

        let cell = fetcher.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual(
            cell.textLabel?.text,
            "FalconSat"
        )
    }

    private func getFetcherAndLoad() -> LaunchFetcher? {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "past_launches", withExtension: "json") else {
            return .none
        }

        let fetcher = LaunchFetcher()
        fetcher.load(from: url)

        return fetcher
    }
}
