import Foundation

import RealmSwift
import RxSwift

protocol ObjectPropertyUpdatable { }
extension ObjectPropertyUpdatable where Self: Object {
    func update(_ block: (Self) throws -> Void) rethrows {
        try? self.realm?.safeWrite {
            try? block(self)
        }
    }
}
extension Object: ObjectPropertyUpdatable { }

protocol RealmTaskType: AnyObject {

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

enum RealmError: Error {
    case noData
}

enum QueryFilter {
    case string(query: String)
    case predicate(query: NSPredicate)
}

enum OrderingType {
    case ascending
    case descending
}

final class RealmTask: RealmTaskType {

    static let shared = RealmTask()

    private var realm: Realm {
        guard let realm = try? Realm() else {
            fatalError("Undefinded Realm")
        }
        return realm
    }

    private init() { }

    func fetchObjects<T: Object>(
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

            if resultArr.isEmpty {
                single(.failure(RealmError.noData))
            } else {
                single(.success(resultArr))
            }

            return Disposables.create()
        }
    }

    func fetchObjectsResults<T: Object>(
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

    func add(_ object: Object?) {
        guard let object = object else { return }
        try? realm.safeWrite {
            realm.add(object)
        }
    }

    func set(_ object: Object?) {
        guard let object = object else { return }
        try? realm.safeWrite {
            realm.add(object, update: .all)
        }
    }

    func set(_ objects: [Object]?) {
        guard let objects = objects else { return }
        try? realm.safeWrite {
            realm.add(objects, update: .all)
        }
    }

    func delete(_ object: Object?) {
        guard let object = object else { return }
        try? realm.safeWrite {
            realm.delete(object)
        }
    }

    func delete(_ objects: [Object]?) {
        guard let objects = objects else { return }
        try? realm.safeWrite {
            realm.delete(objects)
        }
    }

    func deleteAll() {
        try? realm.safeWrite {
            realm.deleteAll()
        }
    }

}
