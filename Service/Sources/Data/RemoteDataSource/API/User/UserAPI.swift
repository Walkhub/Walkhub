import Foundation

import Moya

enum UserAPI {
    case changePassword(accountID: String, phoneNumber: String, authCode: String, newPassword: String)
    case profileInquiry(userID: Int)
    case myPageInquiry
    case badgeInquiry(userID: Int)
    case mainBadgeSet(badgeID: Int)
    case changeProfile(name: String, profileImageUrlString: String, birthday: String, sex: String)
    case findID(phoneNumber: String)
    case writeHealth(height: Float, weight: Int)
    case joinClass(agencyCode: String, grade: Int, class: Int)
}

extension UserAPI: WalkhubAPI {
    
    var domain: ApiDomain {
        .users
    }
    
    var urlPath: String {
        switch self {
        case .changePassword:
            return "/password"
        case .profileInquiry(let userID):
            return "/\(userID)"
        case .badgeInquiry(let userID):
            return "/\(userID)/badges"
        case .mainBadgeSet(let badgeID):
            return "/badges/\(badgeID)"
        case .findID(let phoneNum):
            return "/accounts/\(phoneNum)"
        case .writeHealth:
            return "/healths"
        case .joinClass(let code, let grade, let classNum):
            return "/classes/\(code)/\(grade)/\(classNum)"
        default:
            return "/"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .changeProfile, .changeProfile:
            return .patch
        case .badgeInquiry:
            return .put
        case .joinClass:
            return .post
        default:
            return .get
        }
    }
    
    var jwtTokenType: JWTTokenType? {
        switch self {
        case .changeProfile, .findID:
            return .none
        default:
            return .accessToken
        }
    }
    
}
