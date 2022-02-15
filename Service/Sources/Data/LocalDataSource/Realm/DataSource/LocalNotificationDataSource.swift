import Foundation

import RxSwift

final class LocalNotificationDataSource {

    static let shared = LocalNotificationDataSource()

    private let realmTask = RealmTask.shared

    private init() { }

    func fetchNotificationList() -> Single<[Notification]> {
        return realmTask.fetchObjects(for: NotificationRealmEntity.self)
            .map { $0.map { $0.toDomain() } }
    }

    func storeNotificationList(notificationList: [Notification]) {
        let notificationRealmEntityList = notificationList.map { notification in
            return NotificationRealmEntity().then {
                $0.setup(notification: notification)
            }
        }
        realmTask.set(notificationRealmEntityList)
    }

}
