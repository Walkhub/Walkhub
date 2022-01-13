import Foundation

import Moya

enum AuthAPI {
    case signin
    case signup
    case renewalToken
}

extension AuthAPI: WalkhubAPI {

    var domain: ApiDomain {
        return .users
    }

    var urlPath: String {
        switch self {
        case .signin:
            return "/token"
        case .signup:
            return "/"
        case .renewalToken:
            return "/reissue"
        }
    }

    var method: Moya.Method {
        switch self {
        case .signin, .signup:
            return .post
        case .renewalToken:
            return .put
        }
    }

    var task: Task {
        switch self {
        default:
            return .requestPlain
        }
    }

    var jwtTokenType: JWTTokenType? {
        switch self {
        case .renewalToken:
            return .refreshToken
        default:
            return JWTTokenType.none
        }
    }

}
