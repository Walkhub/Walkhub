import Foundation

extension String {
    func toDate() -> Date {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: TimeZone.current.identifier)
        formatter.timeZone = TimeZone(identifier: TimeZone.current.identifier)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return formatter.date(from: self)!
    }
}
