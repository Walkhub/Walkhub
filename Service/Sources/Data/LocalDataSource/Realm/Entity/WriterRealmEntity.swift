import Foundation

import RealmSwift

class WriterRealmEntity: Object {

    @Persisted(primaryKey: true) var id: Int = 0
    @Persisted var name: String = ""
    @Persisted var profileImageUrlString: String = ""

}

// MARK: Setup
extension WriterRealmEntity {
    func setup(writer: Writer) {
        self.id = writer.id
        self.name = writer.name
        self.profileImageUrlString = writer.profileImageUrl.absoluteString
    }
}

// MARK: - Mappings to Domain
extension WriterRealmEntity {
    func toDomain() -> Writer {
        return .init(
            id: id,
            name: name,
            profileImageUrl: URL(string: profileImageUrlString)!
        )
    }
}
