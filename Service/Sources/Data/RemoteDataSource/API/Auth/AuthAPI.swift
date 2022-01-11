import Foundation

import Moya

enum AuthAPI {

    case renewalToken

}

extension AuthAPI: WalkhubAPI {

    var path: String {
        switch self {
        case .renewalToken:
            return "/users/reissue"
        }
    }

    var method: Moya.Method {
        switch self {
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
        }
    }

}
