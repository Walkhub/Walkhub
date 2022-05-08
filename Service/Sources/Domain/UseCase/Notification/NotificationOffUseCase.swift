import Foundation

import RxSwift

public class NotificationOffUseCase {

    private let notificationRepository: NotificationRepository

    init(notificationRepository: NotificationRepository) {
        self.notificationRepository = notificationRepository
    }

    public func excute(type: NotificationType) -> Completable {
        return notificationRepository.notificationOff(userId: 0, type: type)
    }
}
