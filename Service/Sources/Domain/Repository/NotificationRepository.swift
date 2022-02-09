import Foundation

import RxSwift

protocol NotificationRepository {
    func fetchNotificationList() -> Observable<[Notification]>
    func editReadWhether(notificationId: Int) -> Single<Void>
}
