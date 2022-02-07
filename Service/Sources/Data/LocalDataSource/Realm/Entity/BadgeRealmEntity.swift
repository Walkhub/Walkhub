import Foundation

import RealmSwift

class BadgeRealmEntity: Object {

    @Persisted(primaryKey: true) var compoundKey: String = ""

    @Persisted var ownerID: Int = 0
    @Persisted var id: Int = 0
    @Persisted var name: String = ""
    @Persisted var imageUrlString: String = ""

}

// MARK: Setup
extension BadgeRealmEntity {

    func setup(ownerID: Int, badge: Badge) {
        self.ownerID = ownerID
        self.id = badge.id
        self.name = badge.name
        self.imageUrlString = badge.imageUrl.absoluteString
        self.compoundKey = compoundKeyValue()
    }

    private func compoundKeyValue() -> String {
        return "\(id)\(ownerID)"
    }

}

// MARK: - Mappings to Domain
extension BadgeRealmEntity {
    func toDomain() -> Badge {
        return .init(
            id: id,
            name: name,
            imageUrl: URL(string: imageUrlString)!
        )
    }
}
