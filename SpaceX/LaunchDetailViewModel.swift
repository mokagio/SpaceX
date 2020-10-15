import Foundation

extension LaunchDetail {

    class ViewModel {
        let name: String
        let timeSinceLaunch: String

        init(launch: Launch, currentDate: Date = Date()) {
            self.name = launch.name
            self.timeSinceLaunch = "\(currentDate.timeIntervalSince(launch.date).rounded().toInt())"
        }
    }
}
