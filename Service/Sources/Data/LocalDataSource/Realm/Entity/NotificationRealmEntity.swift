import Foundation

import RealmSwift

class NotificationRealmEntity: Object {

    @Persisted(primaryKey: true) var id: Int = 0
    @Persisted var title: String = ""
    @Persisted var content: String = ""
    @Persisted var type: String = ""
    @Persisted var data: String = ""
    @Persisted var writer: WriterRealmEntity?
    @Persisted var created: String = ""
    @Persisted var isRead: Bool = false

}

// MARK: Setup
extension NotificationRealmEntity {
    func setup(notification: NotificationData) {
        self.id = notification.id
        self.title = notification.title
        self.content = notification.content
        self.type = notification.type.rawValue
        self.data = notification.data
        self.writer = WriterRealmEntity().then {
            $0.setup(writer: notification.writer)
        }
        self.created = notification.created.toDateString()
        self.isRead = notification.isRead
    }
}

// MARK: - Mappings to Domain
extension NotificationRealmEntity {
    func toDomain() -> NotificationData {
        return .init(
            id: id,
            title: title,
            content: content,
            type: NotificationType(rawValue: type) ?? .notification,
            data: data,
            writer: writer!.toDomain(),
            created: created.toDateWithTime(),
            isRead: isRead
        )
    }
}
