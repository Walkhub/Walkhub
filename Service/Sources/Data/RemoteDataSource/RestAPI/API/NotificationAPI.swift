import Foundation

import Moya

enum NotificationAPI {
    case fetchNotificationList
    case toggleIsRead(notificationId: Int)
    case notificationOn(userId: Int, type: NotificationType)
    case notificationOff(userId: Int, type: NotificationType)
    case fetchNotificationStatus
}

extension NotificationAPI: WalkhubAPI {

    var domain: ApiDomain {
        .notifications
    }

    var urlPath: String {
        switch self {
        case .toggleIsRead(let notificationId):
            return "/\(notificationId)"
        case .notificationOn:
            return "/on"
        default:
            return ""
        }
    }

    var method: Moya.Method {
        switch self {
        case .fetchNotificationList, .fetchNotificationStatus:
            return .get
        default:
            return .patch
        }
    }

    var jwtTokenType: JWTTokenType? {
        return .accessToken
    }

    var task: Task {
        switch self {
        case .notificationOn(let userId, let type):
            return .requestParameters(
                parameters: [
                    "users": [
                        userId
                    ],
                    "type": type.rawValue
                ],
                encoding: JSONEncoding.prettyPrinted
            )
        case .notificationOff(let userId, let type):
            return .requestParameters(
                parameters: [
                    "users": [
                        userId
                    ],
                    "type": type.rawValue
                ],
                encoding: JSONEncoding.prettyPrinted
            )
        default:
            return .requestPlain
        }
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
