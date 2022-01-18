import Foundation

import Moya

enum RankAPI {
    case schoolRankInquriy(dateType: String)
    case searchSchool(name: String)
    case userRankInquriy(scope: String, dateType: String, sort: String, agencyCode: String)
    case searchUser(name: String, scope: String, agencyCode: String, grade: Int, classNum: Int)
}

extension RankAPI: WalkhubAPI {
    var domain: ApiDomain {
        .ranks
    }
    
    var urlPath: String {
        switch self {
        case .schoolRankInquriy, .searchSchool:
            return "/schools"
        case .userRankInquriy, .searchUser:
            return "/users"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        switch self {
        case .schoolRankInquriy(let dateType):
            return .requestParameters(
                parameters: [
                    "dateType": dateType
                ],
                encoding: URLEncoding.queryString
            )
        case .searchSchool(let name):
            return .requestParameters(
                parameters: [
                    "name": name
                ], encoding: URLEncoding.queryString
            )
        case .userRankInquriy(let scope, let dateType, let sort, let agencyCode):
            return .requestParameters(
                parameters: [
                    "scope": scope,
                    "dateType": dateType,
                    "sort": sort,
                    "agencyCode": agencyCode
                ], encoding: URLEncoding.queryString
            )
        case .searchUser(let name, let scope, let agencyCode, let grade, let classNum):
            return .requestParameters(
                parameters: [
                    "name": name,
                    "scope": scope,
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
    
    
}
