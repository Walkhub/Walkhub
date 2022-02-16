import Foundation

import Moya

enum SchoolAPI {
    case searchSchool(name: String)
    case fetchSchoolDetails(schoolId: Int)
}

extension SchoolAPI: WalkhubAPI {
    var domain: ApiDomain {
        return .schools
    }

    var urlPath: String {
        switch self {
        case .searchSchool:
            return "/search"
        case .fetchSchoolDetails(let schoolId):
            return "/details/\(schoolId)"
        }
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
        default:
            return .requestPlain
        }
    }

    var method: Moya.Method {
        return .get
    }

    var jwtTokenType: JWTTokenType? {
        return JWTTokenType.none
    }

}
