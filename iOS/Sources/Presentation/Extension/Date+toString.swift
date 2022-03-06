import Foundation

extension Date {
    func toString(dateFormat: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "UTC")
        formatter.timeZone = TimeZone(abbreviation: "KST")
        formatter.dateFormat = dateFormat
        return formatter.string(from: self)
    }
}
