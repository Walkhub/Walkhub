import Foundation

import RxSwift

protocol NotificationRepository {
    func fetchNotificationList() -> Observable<[NotificationData]>
    func editReadWhether(notificationId: Int) -> Single<Void>
}
