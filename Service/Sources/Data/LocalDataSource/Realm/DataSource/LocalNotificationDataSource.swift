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
        let notificationRealmEntityList = notificationList.map { notification in
            return NotificationRealmEntity().then {
                $0.setup(notification: notification)
            }
        }
        RealmTask.shared.set(notificationRealmEntityList)
    }

}
