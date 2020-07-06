import UIKit

// This is _tidy_ because we don't have another object taking of being the `UITableViewDataSource`,
// but at the same time, is it appropriate for this pure data-ish object to cover this role?
extension LaunchFetcher: UITableViewDataSource {

    var identifier: String { "identifier" }
    // Here's a reason why the extension might not be a good idea after all. We can't store this
    // and end up re-evaluating all the time.
    var sections: [SectionSource<Launch>] { groupLaunchesIntoSectionsByName(launches) }

    func bind(to tableView: UITableView) {
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let sec = sections[safe: section] else { return .none }
        return sec.title
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sec = sections[safe: section] else { return 0 }
        return sec.items.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)

        guard let launch = sections[safe: indexPath.section]?.items[safe: indexPath.row] else { return cell }

        cell.textLabel?.text = launch.name

        return cell
    }
}
