import Foundation

import RxSwift

protocol NotificationRepository {
    func fetchNotificationList() -> Observable<[Notification]>
    func editReadWhether(notificationID: Int) -> Single<Void>
}
