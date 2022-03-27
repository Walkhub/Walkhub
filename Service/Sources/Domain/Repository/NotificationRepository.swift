import Foundation

import RxSwift

protocol NotificationRepository {
    func fetchNotificationList() -> Observable<[Notification]>
    func editReadWhether(notificationId: Int) -> Single<Void>
    func notificationOn(type: NotificationType) -> Completable
    func notificationOff(type: NotificationType) -> Completable
}
