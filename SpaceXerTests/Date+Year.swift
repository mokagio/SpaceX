import Foundation

extension Date {

    init(year: Int) {
        guard let date = DateComponents(
            calendar: Calendar.init(identifier: .gregorian),
            year: year
        ).date else {
            fatalError("Unexpectedly failed to init Date from DateComponents")
        }

        self = date
    }
}
