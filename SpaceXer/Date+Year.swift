import Foundation

extension Date {

    var year: Int { Calendar.current.component(.year, from: self) }
}
