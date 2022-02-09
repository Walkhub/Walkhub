import Foundation

import RxSwift

class DefaultNotificationRepository: NotificationRepository {

    func fetchNotificationList() -> Observable<[Notification]> {
        return OfflineCacheUtil<[Notification]>()
            .remoteData { RemoteNotificationDataSource.shared.fetchNotificationList() }
            .localData { LocalNotificationDataSource.shared.fetchNotificationList() }
            .doOnNeedRefresh { LocalNotificationDataSource.shared.storeNotificationList(notificationList: $0) }
            .createObservable()
    }

    func editReadWhether(notificationId: Int) -> Single<Void> {
        return RemoteNotificationDataSource.shared.editReadWhether(notificationId: notificationId)
    }

}
