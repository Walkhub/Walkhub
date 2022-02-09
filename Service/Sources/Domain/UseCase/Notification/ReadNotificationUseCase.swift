import Foundation

import RxSwift

public class ReadNotificationUseCase {

    private let notificationRepository: NotificationRepository

    init(notificationRepository: NotificationRepository) {
        self.notificationRepository = notificationRepository
    }

    public func excute(notificationID: Int) -> Single<Void> {
        notificationRepository.editReadWhether(notificationID: notificationID)
    }

}
