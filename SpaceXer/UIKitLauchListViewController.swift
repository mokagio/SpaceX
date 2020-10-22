import UIKit

class UIKitLaunchListViewController: UIViewController {

    let tableView = UITableView(frame: .zero)
    let identifier = "launchcell"
    let fetcher = LaunchFetcher()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        pin(tableView, to: view)

        fetcher.bind(to: tableView)

        guard let url = Bundle.main.url(forResource: "past_launches", withExtension: "json") else { return }
        let _: [Launch] = fetcher.load(from: url)
    }
}

// TODO: add explanation on this approach. What's good about it? What's not so good about it?
// How could you test this? Does it feel awkward or is it appropriate to have the UIKit layer take
// care of wrapping this UIKit stuff?
extension UIKitLaunchListViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetcher.launches.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)

        guard let launch = fetcher.launches[safe: indexPath.row] else { return cell }

        cell.textLabel?.text = launch.name

        return cell
    }
}
