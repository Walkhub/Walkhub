import Foundation

import RxSwift

public class NotificationOnUseCase {

    private let notificationRepository: NotificationRepository

    init(notificationRepository: NotificationRepository) {
        self.notificationRepository = notificationRepository
    }

    public func excute(type: NotificationType) -> Completable {
        return notificationRepository.notificationOff(type: type)
    }
}
