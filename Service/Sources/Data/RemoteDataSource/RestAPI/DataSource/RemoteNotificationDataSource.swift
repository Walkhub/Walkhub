import Foundation

import Moya
import RxSwift

final class RemoteNotificationDataSource: RestApiRemoteDataSource<NotificationAPI> {

    static let shared = RemoteNotificationDataSource()

    private override init() { }

    func fetchNotificationList() -> Single<[Notification]> {
        return request(.fetchNotificationList)
            .map(NotificationListDTO.self)
            .map { $0.toDomain() }
    }

    func editReadWhether(notificationId: Int) -> Single<Void> {
        return request(.toggleIsRead(notificationId: notificationId))
            .map { _ in () }
    }

    func notificationOn(type: NotificationType) -> Completable {
        return request(.notificationOn(type: type))
            .asCompletable()
    }

    func notificationOff(type: NotificationType) -> Completable {
        return request(.notificationOff(type: type))
            .asCompletable()
    }
}
