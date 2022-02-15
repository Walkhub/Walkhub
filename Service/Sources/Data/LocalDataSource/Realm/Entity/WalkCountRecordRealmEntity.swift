import Foundation

import RealmSwift

class WalkCountRecordRealmEntity: Object {

    @Persisted(primaryKey: true) var index: Int = 0
    @Persisted var walkCount: Int = 0

}

// MARK: Setup
extension WalkCountRecordRealmEntity {
    func setup(index: Int, walkCount: Int) {
        self.index = index
        self.walkCount = walkCount
    }
}

// MARK: - Mappings to Domain
extension WalkCountRecordRealmEntity {
    func toDomain() -> Int {
        return walkCount
    }
}
