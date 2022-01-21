import Foundation

import Moya
import RxSwift

final class RemoteNotificationsDataSource: RemoteBaseDataSource<NotificationsAPI> {

    static let shared = RemoteNotificationsDataSource()

    private override init() { }

    func viewNotificationsList() -> Single<Response> {
        return request(.fetchNotificationsList)
    }

    func editReadWhether(notificationID: Int) -> Single<Response> {
        return request(.toggleIsRead(notificationID: notificationID))
    }

}
