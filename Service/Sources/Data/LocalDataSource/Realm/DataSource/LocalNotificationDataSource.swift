import Foundation

import RxSwift

final class LocalNotificationDataSource {

    static let shared = LocalNotificationDataSource()

    private init() { }

    func fetchNotificationList() -> Single<[Notification]> {
        return RealmTask.shared.fetchObjects(for: NotificationRealmEntity.self)
            .map { $0.map { $0.toDomain() } }
    }

    func storeNotificationList(notificationList: [Notification]) {
        let notificationRealmEntityList: [NotificationRealmEntity] = notificationList.map {
            let notificationRealmEntity = NotificationRealmEntity()
            notificationRealmEntity.setup(notification: $0)
            return notificationRealmEntity
        }
        RealmTask.shared.set(notificationRealmEntityList)
    }

}
