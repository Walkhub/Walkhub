import Foundation

import Moya

enum AuthAPI {
    case signin(id: String, password: String, deviceToken: String)
    case signup(id: String, password: String, name: String, phoneNumber: String, authCode: String)
    case verificationPhone(phoneNumber: String)
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
        case .verificationPhone:
            return "verification-codes"
        case .renewalToken:
            return "/reissue"
        }
    }

    var method: Moya.Method {
        switch self {
        case .signin, .signup, .verificationPhone:
            return .post
        case .renewalToken:
            return .put
        }
    }

    var task: Task {
        switch self {
        case .signin(let id, let password, let deviceToken):
            return .requestParameters(
                parameters: [
                    "account_id": id,
                    "password": password,
                    "device_token": deviceToken
                ],
                encoding: JSONEncoding.default
            )
        case .signup(let id, let password, let name, let phoneNumber, let authCode):
            return .requestParameters(
                parameters: [
                    "account_id": id,
                    "password": password,
                    "name": name,
                    "phone_number": phoneNumber,
                    "auth_code": authCode
                ],
                encoding: JSONEncoding.default
            )
        case .verificationPhone(let phoneNumber):
            return .requestParameters(
                parameters: [
                    "phone_number": phoneNumber
                ],
                encoding: JSONEncoding.default)
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

    var errorMapper: [Int: WalkhubError]? {
        switch self {
        case .signin:
            return [
                401: .wrongPassword,
                404: .wrongId
            ]
        case .signup:
            return [
                404: .invalidAuthCode,
                409: .duplicateId
            ]
        default:
            return nil
        }
    }

}
