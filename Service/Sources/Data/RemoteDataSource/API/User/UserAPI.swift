import Foundation

import Moya

enum UserAPI {
    case changePassword(accountID: String, phoneNumber: String, authCode: String, newPassword: String)
    case fetchProfile(userID: Int)
    case fetchMypage
    case fetchBadge(userID: Int)
    case mainBadgeSet(badgeID: Int)
    case changeProfile(name: String, profileImageUrlString: String, birthday: String, sex: String)
    case findID(phoneNumber: String)
    case writeHealth(height: Float, weight: Int)
    case joinClass(agencyCode: String, grade: Int, classNum: Int)
    case changeSchoolInformation(agencyCode: String)
}

extension UserAPI: WalkhubAPI {
    
    var domain: ApiDomain {
        .users
    }
    
    var urlPath: String {
        switch self {
        case .changePassword:
            return "/password"
        case .fetchProfile(let userID):
            return "/\(userID)"
        case .fetchBadge(let userID):
            return "/\(userID)/badges"
        case .mainBadgeSet(let badgeID):
            return "/badges/\(badgeID)"
        case .findID(let phoneNum):
            return "/accounts/\(phoneNum)"
        case .writeHealth:
            return "/healths"
        case .joinClass(let code, let grade, let classNum):
            return "/classes/\(code)/\(grade)/\(classNum)"
        case .changeSchoolInformation:
            return "/school"
        default:
            return "/"
        }
    }
    
    var task: Task {
        switch self {
        case .changePassword(let accountID, let phoneNumber, let authCode, let newPassword):
            return .requestParameters(
                parameters: [
                    "account_id": accountID,
                    "phone_number": phoneNumber,
                    "auth_code": authCode,
                    "new_password": newPassword
                ],
                encoding: JSONEncoding.prettyPrinted
            )
        case .changeProfile(let name, let profileImageUrlString, let birthday, let sex):
            return .requestParameters(
                parameters: [
                    "name": name,
                    "profile_image_url": profileImageUrlString,
                    "birthday": birthday,
                    "sex": sex
                ],
                encoding: JSONEncoding.prettyPrinted
            )
        case .writeHealth(let height, let weight):
            return .requestParameters(
                parameters: [
                    "height": height,
                    "weight": weight
                ],
                encoding: JSONEncoding.prettyPrinted
            )
        case .changeSchoolInformation(let agencyCode):
            return .requestParameters(
                parameters: [
                    "agency_code": agencyCode
                ],
                encoding: JSONEncoding.prettyPrinted
            )
        default: return .requestPlain
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .changeProfile, .changeProfile, .changeSchoolInformation, .writeHealth:
            return .patch
        case .fetchBadge:
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
