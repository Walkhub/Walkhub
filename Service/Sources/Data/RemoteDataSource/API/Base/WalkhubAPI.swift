import Foundation

import Moya

// MARK: - WalkhubAPI
protocol WalkhubAPI: TargetType, JWTTokenAuthorizable {
    var domain: ApiDomain { get }
    var urlPath: String { get }
    var errorMapper: [Int: WalkhubError]? { get }
}

extension WalkhubAPI {

    var baseURL: URL { URL(string: "https://api.walkhub.co.kr")! }

    var path: String {
        return domain.uri+urlPath
    }

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

// MARK: - ApiDomain enum
enum ApiDomain: String {
    case users
    case exercies
    case notices
    case notification
    case ranks
    case challenges
    case images
    case schools
}

extension ApiDomain {
    var uri: String {
        return "/\(self.rawValue)"
    }
}
