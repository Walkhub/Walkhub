import Foundation

import Moya

enum NotificationsAPI {
    case fetchNotificationsList
    case toggleIsRead(notificationID: Int)
}

extension NotificationsAPI: WalkhubAPI {

    var domain: ApiDomain {
        .notification
    }

    var urlPath: String {
        switch self {
        case .fetchNotificationsList:
            return "/"
        case .toggleIsRead(let notificationID):
            return "/\(notificationID)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .fetchNotificationsList:
            return .get
        case .toggleIsRead:
            return .patch
        }
    }

    var jwtTokenType: JWTTokenType? {
        return .accessToken
    }

    var errorMapper: [Int: WalkhubError]? {
        switch self {
        default:
            return [
                401: .unauthorization
            ]
        }
    }
}
