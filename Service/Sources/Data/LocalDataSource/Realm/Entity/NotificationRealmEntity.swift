import Foundation

import RealmSwift

class NotificationRealmEntity: Object {

    @Persisted(primaryKey: true) var id: Int = 0
    @Persisted var title: String = ""
    @Persisted var content: String = ""
    @Persisted var type: String = ""
    @Persisted var value: Int = 0
    @Persisted var isRead: Bool = false

}

// MARK: Setup
extension NotificationRealmEntity {
    func setup(notification: Notification) {
        self.id = notification.id
        self.title = notification.title
        self.content = notification.content
        self.type = notification.type.rawValue
        self.value = notification.value
        self.isRead = notification.isRead
    }
}

// MARK: - Mappings to Domain
extension NotificationRealmEntity {
    func toDomain() -> Notification {
        return .init(
            id: id,
            title: title,
            content: content,
            type: NotificationType(rawValue: type)!,
            value: value,
            isRead: isRead
        )
    }
}
