import Foundation

extension String {
    func toDate() -> Date {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: TimeZone.current.identifier)
        formatter.timeZone = TimeZone(identifier: TimeZone.current.identifier)
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: self)!
    }
    func toDateWithTime() -> Date {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: TimeZone.current.identifier)
        formatter.timeZone = TimeZone(identifier: TimeZone.current.identifier)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return formatter.date(from: self)!
    }
}

extension Date {
    func toDateWithTimeString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return formatter.string(from: self)
    }
    func toDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: self)
    }
}
