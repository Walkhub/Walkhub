import Foundation

import RealmSwift

extension Results {

    public func toArray() -> [Element] {
        return Array(self)
    }

    public func toArray<T>(type: T.Type) -> [T] {
        return compactMap { $0 as? T }
    }

}
