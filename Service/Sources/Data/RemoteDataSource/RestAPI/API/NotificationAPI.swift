import Foundation

import Moya

enum NotificationAPI {
    case fetchNotificationList
    case toggleIsRead(notificationID: Int)
}

extension NotificationAPI: WalkhubAPI {

    var domain: ApiDomain {
        .notification
    }

    var urlPath: String {
        switch self {
        case .fetchNotificationList:
            return "/"
        case .toggleIsRead(let notificationID):
            return "/\(notificationID)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .fetchNotificationList:
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
