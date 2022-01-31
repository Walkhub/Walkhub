import Foundation

import Moya
import RxSwift

final class RemoteNotificationsDataSource: RestApiRemoteDataSource<NotificationsAPI> {

    static let shared = RemoteNotificationsDataSource()

    private override init() { }

    func viewNotificationsList() -> Single<[Notification]> {
        return request(.fetchNotificationsList)
            .map(NotificationListDTO.self)
            .map { $0.toDomain() }
    }

    func editReadWhether(notificationID: Int) -> Single<Void> {
        return request(.toggleIsRead(notificationID: notificationID))
            .map { _ in () }
    }

}
