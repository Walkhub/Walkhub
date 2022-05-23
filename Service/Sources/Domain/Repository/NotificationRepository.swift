import Foundation

import RxSwift

protocol NotificationRepository {
    func fetchNotificationList() -> Observable<[Notification]>
    func editReadWhether(notificationId: Int) -> Single<Void>
    func notificationOn(userId: Int, type: NotificationType) -> Completable
    func notificationOff(userId: Int, type: NotificationType) -> Completable
    func fetchNotificationStatus() -> Observable<[NotificationStatus]>
}
