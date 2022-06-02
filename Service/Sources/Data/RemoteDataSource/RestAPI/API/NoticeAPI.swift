import Foundation

import Moya

enum NoticeAPI {
    case fetchNotice
}

extension NoticeAPI: WalkhubAPI {

    var domain: ApiDomain {
        .notices
    }

    var urlPath: String {
        return "/list"
    }

    var method: Moya.Method {
        return .get
    }

    var task: Task {
        return .requestParameters(
            parameters: [
                "scope": GroupScope.school.rawValue
            ], encoding: URLEncoding.queryString
        )
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
