import Foundation

import Moya

enum SchoolAPI {
    case searchSchool(name: String)
}

extension SchoolAPI: WalkhubAPI {
    var domain: ApiDomain {
        return .schools
    }

    var urlPath: String {
        return "/search"
    }

    var errorMapper: [Int : WalkhubError]? {
        return [
            401: .undefinededSchool
        ]
    }

    var task: Task {
        switch self {
        case .searchSchool(let name):
            return .requestParameters(
                parameters: ["name": name],
                encoding: URLEncoding.queryString
            )
        }
    }

    var method: Moya.Method {
        return .get
    }

    var jwtTokenType: JWTTokenType? {
        return JWTTokenType.none
    }

}
