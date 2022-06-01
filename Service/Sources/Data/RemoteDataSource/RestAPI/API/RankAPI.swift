import Foundation

import Moya

enum RankAPI {
    case fetchSchoolRank
    case searchSchoolRank(name: String?, dateType: DateType)
    case fetchMySchoolUserRank(scope: GroupScope, dateType: DateType)
    case fetchAnotherSchoolUserRank(schoolId: Int, dateType: DateType)
    case searchUser(name: String, dateType: DateType, schoolId: Int)
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
        case .fetchMySchoolUserRank:
            return "/users/my-school"
        case .fetchAnotherSchoolUserRank(let schoolId, _):
            return "/users/\(schoolId)"
        case .searchUser(_, _, let schoolId):
            return "/users/search/\(schoolId)"
        }
    }

    var method: Moya.Method {
        return .get
    }

    var task: Task {
        switch self {
        case .searchSchoolRank(let name, let dateType):
            return .requestParameters(
                parameters: [
                    "name": name,
                    "sort": Sort.rank.rawValue,
                    "scope": GroupScope.all.rawValue,
                    "schoolDateType": dateType.rawValue
                ], encoding: URLEncoding.queryString
            )
        case .fetchMySchoolUserRank(let scope, let dateType):
            return .requestParameters(
                parameters: [
                    "scope": scope.rawValue,
                    "dateType": dateType.rawValue
                ], encoding: URLEncoding.queryString
            )
        case .fetchAnotherSchoolUserRank(_, let dateType):
            return .requestParameters(
                parameters: [
                    "dateType": dateType.rawValue
                ],
                encoding: URLEncoding.queryString
            )
        case .searchUser(let name, let dateType, _):
            return .requestParameters(
                parameters: [
                    "name": name,
                    "dateType": dateType.rawValue
                ], encoding: URLEncoding.queryString
            )
        default:
            return .requestPlain
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
