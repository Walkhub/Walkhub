import Foundation

import Moya

enum NotificationsAPI {
    case viewNotificationsList
    case editReadWhether(notificationID: Int)
}

extension NotificationsAPI: WalkhubAPI {
    var domain: ApiDomain {
        .notification
    }
    
    var urlPath: String {
        switch self {
        case .viewNotificationsList:
            return "/"
        case .editReadWhether(let notificationID):
            return "/\(notificationID)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .viewNotificationsList:
            return .get
        case .editReadWhether:
            return .patch
        }
    }
    
    var jwtTokenType: JWTTokenType? {
        return .accessToken
    }
}
