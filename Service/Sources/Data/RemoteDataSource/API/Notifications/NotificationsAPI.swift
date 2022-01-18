//
//  NotificationsAPI.swift
//  Service
//
//  Created by kimsian on 2022/01/18.
//

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
        case .editReadWhether(notificationID: _):
            return .patch
        }
    }
    
    var jwtTokenType: JWTTokenType? {
        return .accessToken
    }
}
