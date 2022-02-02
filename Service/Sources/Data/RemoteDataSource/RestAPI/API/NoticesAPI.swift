import Foundation

import Moya

enum NoticesAPI {
    case fetchNotice
}

extension NoticesAPI: WalkhubAPI {

    var domain: ApiDomain {
        .notices
    }

    var urlPath: String {
        return "/list"
    }

    var method: Moya.Method {
        return .get
    }

    var jwtTokenType: JWTTokenType? {
        return .accessToken
    }

    var errorMapper: [Int: WalkhubError]? {
        switch self {
        case .fetchNotice:
            return [
                401: .unauthorization
            ]
        }
    }

}
