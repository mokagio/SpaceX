@testable import SpaceXer
import XCTest

class LaunchFetcherUITableViewDataSourceTests: XCTestCase {

    func testDataSourceNumberOfRows() throws {
        let fetcher = try XCTUnwrap(getFetcherAndLoad())
        let tableView = UITableView()
        fetcher.bind(to: tableView)

        // Unfortunately, because the fetcher is designed to work on the URL, and I don't have a
        // way to generate fixture files at runtime for which I could feed a URL to the fetcher,
        // this assertion is a bit cryptic, and to be sure the value is correct one would have to
        // manually count all of the launches starting with "a" in the JSON source.
        XCTAssertEqual(
            fetcher.tableView(tableView, numberOfRowsInSection: 0),
            1
        )
        // An alternative is to duplicate some logic here in the tests. Kent Beck is fine with that
        // in TDD by Examples. I'm not sure how I feel about it yet.
        XCTAssertEqual(
            fetcher.tableView(tableView, numberOfRowsInSection: 0),
            fetcher.launches.filter { $0.name == "FalconSat" }.count
        )
    }

    func testDataSourceCellForRowAtIndex() throws {
        let fetcher = try XCTUnwrap(getFetcherAndLoad())
        let tableView = UITableView()
        fetcher.bind(to: tableView)

        let cell = fetcher.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        // Like above, this test requires the reader to open the JSON fixture file to understand
        // where the expected value comes from. On top of that, because of the logic grouping
        // launches in alphabetically sorted sections, one would have to manually hunt the first
        // match in the JSON, which could be time consuming.
        XCTAssertEqual(
            cell.textLabel?.text,
            "FalconSat"
        )
        // Again, one alternative is to add some logic to compute the expectation.
        XCTAssertEqual(
            cell.textLabel?.text,
            fetcher.launches.filter { $0.name == "FalconSat" }.sorted { $0.name < $1.name }.first?.name
        )
    }

    private func getFetcherAndLoad() -> LaunchFetcher? {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "past_launches", withExtension: "json") else {
            return .none
        }

        let fetcher = LaunchFetcher()
        let _: [Launch] = fetcher.load(from: url)

        return fetcher
    }
}
