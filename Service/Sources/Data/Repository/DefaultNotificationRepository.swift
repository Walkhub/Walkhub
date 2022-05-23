import Foundation

import RxSwift

class DefaultNotificationRepository: NotificationRepository {

    private let remoteNotificationDataSource = RemoteNotificationDataSource.shared
    private let localNotificationDataSource = LocalNotificationDataSource.shared

    func fetchNotificationList() -> Observable<[Notification]> {
        return OfflineCacheUtil<[Notification]>()
            .localData { self.localNotificationDataSource.fetchNotificationList() }
            .remoteData { self.remoteNotificationDataSource.fetchNotificationList() }
            .doOnNeedRefresh { self.localNotificationDataSource.storeNotificationList(notificationList: $0) }
            .createObservable()
    }

    func editReadWhether(notificationId: Int) -> Single<Void> {
        return remoteNotificationDataSource.editReadWhether(notificationId: notificationId)
    }

    func notificationOn(userId: Int, type: NotificationType) -> Completable {
        return remoteNotificationDataSource.notificationOn(userId: userId, type: type)
    }

    func notificationOff(userId: Int, type: NotificationType) -> Completable {
        return remoteNotificationDataSource.notificationOff(userId: userId, type: type)
    }

    func fetchNotificationStatus() -> Observable<[NotificationStatus]> {
        return remoteNotificationDataSource.fetchNotificaitonStatus()
    }
}
