import Foundation

import RxSwift

public class FetchNotificationListUseCase {

    private let notificationRepository: NotificationRepository

    init(notificationRepository: NotificationRepository) {
        self.notificationRepository = notificationRepository
    }

    public func excute() -> Observable<[NotificationData]> {
        notificationRepository.fetchNotificationList()
    }

}
