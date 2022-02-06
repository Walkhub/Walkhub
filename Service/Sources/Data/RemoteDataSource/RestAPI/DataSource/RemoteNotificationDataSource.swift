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

    func editReadWhether(notificationID: Int) -> Single<Void> {
        return request(.toggleIsRead(notificationID: notificationID))
            .map { _ in () }
    }

}
