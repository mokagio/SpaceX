import UIKit

// This is _tidy_ because we don't have another object taking of being the `UITableViewDataSource`,
// but at the same time, is it appropriate for this pure data-ish object to cover this role?
extension LaunchFetcher: UITableViewDataSource {

    var identifier: String { "identifier" }

    func bind(to tableView: UITableView) {
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return launches.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)

        guard let launch = launches[safe: indexPath.row] else { return cell }

        cell.textLabel?.text = launch.name

        return cell
    }
}
