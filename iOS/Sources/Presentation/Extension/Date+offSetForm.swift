import Foundation

extension Date {
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfYear], from: date, to: self).weekOfYear ?? 0
    }
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    func offset(from date: Date) -> String {
        if years(from: date)   > 0 { return "\(years(from: date))년 전"   }
        if months(from: date)  > 0 { return "\(months(from: date))달 전"  }
        if weeks(from: date)   > 0 { return "\(weeks(from: date))주 전"   }
        if days(from: date)    > 0 { return "\(days(from: date))일 전"    }
        if hours(from: date)   > 0 { return "\(hours(from: date))시간 전"  }
        if minutes(from: date) > 0 { return "\(minutes(from: date))분 전" }
        if seconds(from: date) > 0 { return "\(seconds(from: date))초 전" }
        return ""
    }
}
