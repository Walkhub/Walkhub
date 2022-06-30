import Foundation

import Moya

enum AuthAPI {
    case signin(id: String, password: String, deviceToken: String)
    case signup(id: String, password: String, name: String, phoneNumber: String, authCode: String, schoolId: Int, deviceToken: String)
    case verificationPhone(phoneNumber: String)
    case checkVerificationCode(verificationCode: String, phoneNumber: String)
    case renewalToken
    case findID(phoneNumber: String)
    case checkAccountId(accountId: String)
}

extension AuthAPI: WalkhubAPI {

    var domain: ApiDomain {
        return .users
    }

    var urlPath: String {
        switch self {
        case .signin, .renewalToken:
            return "/token"
        case .signup:
            return ""
        case .verificationPhone, .checkVerificationCode:
            return "/verification-codes"
        case .findID(let phoneNum):
            return "/accounts/\(phoneNum)"
        case .checkAccountId:
            return "/account-id"
        }
    }

    var method: Moya.Method {
        switch self {
        case .signin, .signup, .verificationPhone:
            return .post
        case .renewalToken:
            return .patch
        case .findID:
            return .get
        default:
            return .head
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
        case .signup(let id, let password, let name, let phoneNumber, let authCode, let schoolId, let deviceToken):
            return .requestParameters(
                parameters: [
                    "account_id": id,
                    "password": password,
                    "name": name,
                    "phone_number": phoneNumber,
                    "height": 0.0,
                    "weight": nil,
                    "sex": Sex.noAnswer.rawValue,
                    "school_id": schoolId,
                    "auth_code": authCode,
                    "device_token": deviceToken
                ],
                encoding: JSONEncoding.default
            )
        case .verificationPhone(let phoneNumber):
            return .requestParameters(
                parameters: [
                    "phone_number": phoneNumber
                ],
                encoding: JSONEncoding.default
            )
        case .checkVerificationCode(let verificationCode, let phoneNumber):
            return .requestParameters(
                parameters: [
                    "phoneNumber": phoneNumber,
                    "authCode": verificationCode
                ],
                encoding: URLEncoding.queryString
            )
        case .checkAccountId(let accountId):
            return .requestParameters(
                parameters: [
                    "accountId": accountId
                ],
                encoding: URLEncoding.queryString
            )
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
        case .findID:
            return [
                404: .wrongPhoneNumber
            ]
        default:
            return nil
        }
    }

}
