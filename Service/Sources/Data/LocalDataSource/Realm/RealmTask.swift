import Foundation

import RealmSwift
import RxSwift

public protocol ObjectPropertyUpdatable { }
extension ObjectPropertyUpdatable where Self: Object {
    public func update(_ block: (Self) throws -> Void) rethrows {
        try? self.realm?.safeWrite {
            try? block(self)
        }
    }
}
extension Object: ObjectPropertyUpdatable { }

public protocol RealmTaskType: AnyObject {

    func fetchObjects<T: Object>(
        for type: T.Type,
        filter: QueryFilter?,
        sortProperty: String?,
        ordering: OrderingType
    ) -> Single<[T]>

    func add(_ object: Object?)
    func set(_ object: Object?)
    func set(_ objects: [Object]?)
    func delete(_ object: Object?)
    func delete(_ objects: [Object]?)

}

public enum QueryFilter {
    case string(query: String)
    case predicate(query: NSPredicate)
}

public enum OrderingType {
    case ascending
    case descending
}

public final class RealmTask: RealmTaskType {

    public static let shared = RealmTask()

    private var realm: Realm {
        guard let realm = try? Realm() else {
            fatalError("Undefinded Realm")
        }
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        return realm
    }

    private init() { }

    public func fetchObjects<T: Object>(
        for type: T.Type,
        filter: QueryFilter? = nil,
        sortProperty: String? = nil,
        ordering: OrderingType = .ascending
    ) -> Single<[T]> {
        return Single<[T]>.create { single in
            let resultArr = self.fetchObjectsResults(
                for: T.self,
                filter: filter,
                sortProperty: sortProperty,
                ordering: ordering
            ).toArray()
            single(.success(resultArr))
            return Disposables.create()
        }
    }

    public func fetchObjectsResults<T: Object>(
        for type: T.Type,
        filter: QueryFilter? = nil,
        sortProperty: String? = nil,
        ordering: OrderingType = .ascending
    ) -> Results<T> {
        var results = realm.objects(T.self)
        if let filter = filter {
            switch filter {
            case let .predicate(query):
                results = results.filter(query)
            case let .string(query):
                results = results.filter(query)
            }
        }
        if let sortProperty = sortProperty {
            results = results.sorted(byKeyPath: sortProperty, ascending: ordering == .ascending)
        }
        return results
    }

    public func add(_ object: Object?) {
        guard let object = object else { return }
        try? realm.safeWrite {
            realm.add(object)
        }
    }

    public func set(_ object: Object?) {
        guard let object = object else { return }
        try? realm.safeWrite {
            realm.add(object, update: .all)
        }
    }

    public func set(_ objects: [Object]?) {
        guard let objects = objects else { return }
        try? realm.safeWrite {
            realm.add(objects, update: .all)
        }
    }

    public func delete(_ object: Object?) {
        guard let object = object else { return }
        try? realm.safeWrite {
            realm.delete(object)
        }
    }

    public func delete(_ objects: [Object]?) {
        guard let objects = objects else { return }
        try? realm.safeWrite {
            realm.delete(objects)
        }
    }

    public func deleteAll() {
        try? realm.safeWrite {
            realm.deleteAll()
        }
    }

}
