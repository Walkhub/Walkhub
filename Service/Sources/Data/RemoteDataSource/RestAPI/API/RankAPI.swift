import Foundation

import Moya

enum RankAPI {
    case fetchSchoolRank(dateType: DateType)
    case searchSchool(name: String)
    case fetchUserSchoolRank(scope: Scope, dateType: DateType)
    case fetchUserRank(scope: Scope, dateType: DateType, agencyCode: String)
    case searchUser(name: String, scope: Scope, agencyCode: String, grade: Int, classNum: Int)
}

extension RankAPI: WalkhubAPI {

    var domain: ApiDomain {
        .ranks
    }

    var urlPath: String {
        switch self {
        case .fetchSchoolRank:
            return "/schools"
        case .searchSchool:
            return "/"
        case .fetchUserSchoolRank:
            return "/users/my-school"
        case .fetchUserRank:
            return "/users"
        case .searchUser:
            return "/search"
        }
    }

    var method: Moya.Method {
        return .get
    }

    var task: Task {
        switch self {
        case .fetchSchoolRank(let dateType):
            return .requestParameters(
                parameters: [
                    "dateType": dateType.rawValue
                ],
                encoding: URLEncoding.queryString
            )
        case .searchSchool(let name):
            return .requestParameters(
                parameters: [
                    "name": name
                ], encoding: URLEncoding.queryString
            )
        case .fetchUserSchoolRank(let scope, let dateType):
            return .requestParameters(
                parameters: [
                    "scope": scope.rawValue,
                    "dateType": dateType.rawValue
                ], encoding: URLEncoding.queryString
            )
        case .fetchUserRank(let scope, let dateType, let agencyCode):
            return .requestParameters(
                parameters: [
                    "scope": scope.rawValue,
                    "dateType": dateType.rawValue,
                    "agencyCode": agencyCode
                ],
                encoding: URLEncoding.queryString
            )
        case .searchUser(let name, let scope, let agencyCode, let grade, let classNum):
            return .requestParameters(
                parameters: [
                    "name": name,
                    "scope": scope.rawValue,
                    "agencyCode": agencyCode,
                    "grade": grade,
                    "classNum": classNum
                ], encoding: URLEncoding.queryString
            )
        }
    }

    var jwtTokenType: JWTTokenType? {
        return .accessToken
    }

    var errorMapper: [Int: WalkhubError]? {
        switch self {
        default:
            return [
                401: .unauthorization
            ]
        }
    }

}
