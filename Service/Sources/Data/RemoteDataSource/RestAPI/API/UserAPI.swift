import Foundation

import Moya

enum UserAPI {
    case checkPassword(currentPw: String)
    case changePassword(accountID: String, phoneNumber: String, authCode: String, newPassword: String)
    case fetchProfile(userID: Int)
    case fetchMyProfile
    case changeProfile(name: String, profileImageUrlString: String, schoolId: Int)
    case setHealthInformation(height: Double, weight: Int, sex: Sex)
    case joinClass(sectionId: Int, classCode: String, num: Int)
    case setSchoolInformation(schoolId: Int)
    case changeGoalWalkCount(goalWalkCount: Int)
    case fetchHealthInformation
}

extension UserAPI: WalkhubAPI {

    var domain: ApiDomain {
        .users
    }

    var urlPath: String {
        switch self {
        case .checkPassword:
            return "/verification-password"
        case .changePassword:
            return "/password"
        case .fetchProfile(let userID):
            return "/\(userID)"
        case .setHealthInformation, .fetchHealthInformation:
            return "/health"
        case .joinClass(let sectionId, _, _):
            return "/classes/\(sectionId)"
        case .changeGoalWalkCount:
            return "/goal"
        default:
            return ""
        }
    }

    var task: Task {
        switch self {
        case .checkPassword(let currentPw):
            return .requestParameters(
                parameters: [
                    "password": currentPw
                ],
                encoding: JSONEncoding.default
            )
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
        case .changeProfile(let name, let profileImageUrlString, let schoolId):
            return .requestParameters(
                parameters: [
                    "name": name,
                    "profile_image_url": profileImageUrlString,
                    "school_id": schoolId
                ],
                encoding: JSONEncoding.prettyPrinted
            )
        case .setHealthInformation(let height, let weight, let sex):
            print(height, weight, sex.rawValue)
            return .requestParameters(
                parameters: [
                    "height": height,
                    "weight": weight,
                    "sex": sex.rawValue
                ],
                encoding: JSONEncoding.prettyPrinted
            )
        case .joinClass(_, let classCode, let num):
            return .requestParameters(
                parameters: [
                    "class_code": classCode,
                    "number": num
                ],
                encoding: JSONEncoding.prettyPrinted
            )
        case .changeGoalWalkCount(let goalWalkCount):
            return .requestParameters(
                parameters: [
                    "daily_walk_count_goal": goalWalkCount
                ],
                encoding: JSONEncoding.prettyPrinted
            )
        default: return .requestPlain
        }
    }

    var method: Moya.Method {
        switch self {
        case .changeProfile, .changePassword, .setHealthInformation:
            return .patch
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
        default:
            return [
                401: .unauthorization
            ]
        }
    }
}
// 356 1436 2315 13
