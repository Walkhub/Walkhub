import Foundation

import RxSwift

public class FetchNotificationStatusUseCase {
    private let notificationRepository: NotificationRepository

    init(notificationRepository: NotificationRepository) {
        self.notificationRepository = notificationRepository
    }

    public func excute() -> Single<NotificationStatus> {
        return notificationRepository.fetchNotificationStatus()
    }
}
