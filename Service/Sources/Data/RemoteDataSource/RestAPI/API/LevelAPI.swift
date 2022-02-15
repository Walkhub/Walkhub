import Foundation

import Moya

enum LevelAPI {
    case fetchCaloriesLevelList
    case setMaxCaloriesLavel(levelId: Int)
}

extension LevelAPI: WalkhubAPI {
    var domain: ApiDomain {
        return .levels
    }

    var urlPath: String {
        switch self {
        case .fetchCaloriesLevelList:
            return "/list"
        case .setMaxCaloriesLavel(let levelId):
            return "/\(levelId)"
        }
    }

    var errorMapper: [Int : WalkhubError]? {
        switch self {
        case .fetchCaloriesLevelList:
            return [
                401: .unauthorization
            ]
        case .setMaxCaloriesLavel:
            return [
                401: .unauthorization,
                404: .undefindedLevel
            ]
        }
    }

    var method: Moya.Method {
        switch self {
        case .setMaxCaloriesLavel:
            return .patch
        case .fetchCaloriesLevelList:
            return .get
        }
    }

    var jwtTokenType: JWTTokenType? {
        return .accessToken
    }
}
