import Foundation

import RxSwift

class DefaultNotificationRepository: NotificationRepository {

    private let remoteNotificationDataSource = RemoteNotificationDataSource.shared
    private let localNotificationDataSource = LocalNotificationDataSource.shared

    func fetchNotificationList() -> Observable<[Notification]> {
        return OfflineCacheUtil<[Notification]>()
            .localData { localNotificationDataSource.fetchNotificationList() }
            .remoteData { remoteNotificationDataSource.fetchNotificationList() }
            .doOnNeedRefresh { localNotificationDataSource.storeNotificationList(notificationList: $0) }
            .createObservable()
    }

    func editReadWhether(notificationId: Int) -> Single<Void> {
        return remoteNotificationDataSource.editReadWhether(notificationId: notificationId)
    }

}
