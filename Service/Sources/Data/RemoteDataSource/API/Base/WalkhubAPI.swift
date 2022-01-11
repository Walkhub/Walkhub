import Foundation

import Moya

protocol WalkhubAPI: TargetType, JWTTokenAuthorizable { }

extension WalkhubAPI {

    var baseURL: URL { URL(string: "https://api.walkhub.co.kr")! }

    var task: Task { .requestPlain }

    var validationType: ValidationType {
        return .successCodes
    }

    var headers: [String: String]? {
        switch self {
        default:
            return ["Content-Type": "application/json"]
        }
    }

}
