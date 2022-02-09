import Foundation

import Moya

enum UserAPI {
    case changePassword(accountID: String, phoneNumber: String, authCode: String, newPassword: String)
    case fetchProfile(userID: Int)
    case fetchMyProfile
    case fetchBadges(userID: Int)
    case setMainBadge(badgeId: Int)
    case changeProfile(name: String, profileImageUrlString: String, birthday: String, sex: Sex)
    case setHealthInformation(height: Float, weight: Int)
    case joinClass(schoolId: String, grade: Int, classNum: Int)
    case setSchoolInformation(schoolId: String)
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
        case .fetchBadges(let userID):
            return "/\(userID)/badges"
        case .setMainBadge(let badgeId):
            return "/badges/\(badgeId)"
        case .setHealthInformation:
            return "/healths"
        case .joinClass(let code, let grade, let classNum):
            return "/classes/\(code)/\(grade)/\(classNum)"
        case .setSchoolInformation:
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
                    "sex": sex.rawValue
                ],
                encoding: JSONEncoding.prettyPrinted
            )
        case .setHealthInformation(let height, let weight):
            return .requestParameters(
                parameters: [
                    "height": height,
                    "weight": weight
                ],
                encoding: JSONEncoding.prettyPrinted
            )
        case .setSchoolInformation(let schoolId):
            return .requestParameters(
                parameters: [
                    "school_id": schoolId
                ],
                encoding: JSONEncoding.prettyPrinted
            )
        default: return .requestPlain
        }
    }

    var method: Moya.Method {
        switch self {
        case .changeProfile, .changePassword, .setSchoolInformation, .setHealthInformation:
            return .patch
        case .fetchBadges:
            return .put
        case .joinClass:
            return .post
        default:
            return .get
        }
    }

    var jwtTokenType: JWTTokenType? {
        switch self {
        default:
            return .accessToken
        }
    }

    var errorMapper: [Int: WalkhubError]? {
        switch self {
        case .joinClass:
            return [
                401: .unauthorization,
                403: .inaccessibleClass,
                404: .undefinededClass,
                409: .alreadyJoinedClass
            ]
        case .setSchoolInformation:
            return [
                401: .unauthorization,
                404: .undefinededSchool
            ]
        default:
            return [
                401: .unauthorization
            ]
        }
    }
}
