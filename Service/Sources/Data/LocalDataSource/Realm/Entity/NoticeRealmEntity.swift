import Foundation

import RealmSwift
import Then

class NoticeRealmEntity: Object {

    @Persisted var id: Int = 0
    @Persisted var title: String = ""
    @Persisted var content: String = ""
    @Persisted var createdAt: String = ""
    @Persisted var writer: WriterRealmEntity?

}

// MARK: Setup
extension NoticeRealmEntity {
    func setup(notice: Notice) {
        self.id = notice.id
        self.title = notice.title
        self.content = notice.content
        self.createdAt = notice.createdAt.toDateWithTimeString()
        self.writer = WriterRealmEntity().then {
            $0.setup(writer: notice.writer)
        }
    }
}

// MARK: - Mappings to Domain
extension NoticeRealmEntity {
    func toDomain() -> Notice {
        return .init(
            id: id,
            title: title,
            content: content,
            createdAt: createdAt.toDateWithTime(),
            writer: writer!.toDomain()
        )
    }
}
