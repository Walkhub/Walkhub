import Foundation

import Moya

enum BadgeAPI {
    case fetchUserBadgeList(userId: Int)
    case setMainBadge(badgeId: Int)
    case fetchGetBadges
    case fetchMyBadgeList
}

extension BadgeAPI: WalkhubAPI {
    var domain: ApiDomain {
        return .badges
    }

    var urlPath: String {
        switch self {
        case .fetchGetBadges:
            return "/new"
        case .fetchMyBadgeList:
            return "/"
        case .fetchUserBadgeList(let userId):
            return "/\(userId)"
        case .setMainBadge(let badgeId):
            return "/\(badgeId)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .fetchGetBadges, .fetchMyBadgeList, .fetchUserBadgeList:
            return .get
        default:
            return .put
        }
    }

    var jwtTokenType: JWTTokenType? {
        return .accessToken
    }

    var errorMapper: [Int: WalkhubError]? {
        switch self {
        case .fetchUserBadgeList:
            return [
                401: .unauthorization,
                404: .undefinededUser
            ]
        case .setMainBadge:
            return [
                401: .unauthorization,
                404: .undefinededUser
            ]
        case .fetchGetBadges:
            return [
                401: .unauthorization
            ]
        case .fetchMyBadgeList:
            return [
                401: .unauthorization
            ]
        }
    }
}
