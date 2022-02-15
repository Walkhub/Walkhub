import Foundation

extension Date {
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "UTC")
        formatter.timeZone = TimeZone(abbreviation: "KST")
        formatter.dateFormat = "M.dd"
        return formatter.string(from: self)
    }
}
