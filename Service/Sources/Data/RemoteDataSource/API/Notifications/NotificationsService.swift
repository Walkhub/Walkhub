import Foundation

import Moya
import RxSwift

final class NotificationsService: BaseService<NotificationsAPI> {
    func viewNotificationsList() -> Single<Response> {
        return request(.fetchNotificationsList)
    }
    func editReadWhether(notificationID: Int) -> Single<Response> {
        return request(.toggleIsRead(notificationID: notificationID))
    }
}
