import Foundation

import Moya

enum RankAPI {
    case fetchSchoolRank(dateType: DateType)
    case searchSchoolRank(name: String?, dateType: DateType)
    case fetchUserSchoolRank(scope: GroupScope, dateType: DateType)
    case fetchUserRank(schoolId: Int, dateType: DateType)
    case searchUser(name: String, dateType: DateType)
}

extension RankAPI: WalkhubAPI {

    var domain: ApiDomain {
        .ranks
    }

    var urlPath: String {
        switch self {
        case .fetchSchoolRank:
            return "/schools"
        case .searchSchoolRank:
            return "/schools/search"
        case .fetchUserSchoolRank:
            return "/users/my-school"
        case .fetchUserRank(let schoolId, _):
            return "/users/\(schoolId)"
        case .searchUser:
            return "/users/search"
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
                    "schoolDateType": dateType.rawValue
                ],
                encoding: URLEncoding.queryString
            )
        case .searchSchoolRank(let name, let dateType):
            return .requestParameters(
                parameters: [
                    "name": name,
                    "sort": Sort.rank.rawValue,
                    "scope": GroupScope.all.rawValue,
                    "schoolDateType": dateType.rawValue
                ], encoding: URLEncoding.queryString
            )
        case .fetchUserSchoolRank(let scope, let dateType):
            return .requestParameters(
                parameters: [
                    "scope": scope.rawValue,
                    "dateType": dateType.rawValue
                ], encoding: URLEncoding.queryString
            )
        case .fetchUserRank(_, let dateType):
            return .requestParameters(
                parameters: [
                    "dateType": dateType.rawValue
                ],
                encoding: URLEncoding.queryString
            )
        case .searchUser(let name, let dateType):
            return .requestParameters(
                parameters: [
                    "name": name,
                    "dateType": dateType.rawValue
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
