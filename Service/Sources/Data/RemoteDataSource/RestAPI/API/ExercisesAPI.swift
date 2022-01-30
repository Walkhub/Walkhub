import Foundation

import Moya

enum ExercisesAPI {
    case startRecord(goal: Int, goalType: String)
    case endRecord(exercisesID: Int, walkCount: Int, distance: Int, imageUrlString: String)
    case saveLocations(exercisesID: Int, order: Int, latitude: String, longitude: String)
    case setExsercises(date: String, distance: Int, walkCount: Int)
}

extension ExercisesAPI: WalkhubAPI {

    var domain: ApiDomain {
        .exercies
    }

    var urlPath: String {
        switch self {
        case .startRecord:
            return "/"
        case .endRecord(let exercisesID, _, _, _):
            return "/\(exercisesID)"
        case .saveLocations(let exercisesID, _, _, _):
            return "/locations/\(exercisesID)"
        case .setExsercises(let date, _, _):
            return "?date=\(date)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .startRecord, .saveLocations:
            return .post
        case .endRecord:
            return .patch
        default:
            return .put
        }
    }

    var task: Task {
        switch self {
        case .startRecord(let goal, let goalType):
            return .requestParameters(
                parameters: [
                    "goal": goal,
                    "goal_type": goalType
                ],
                encoding: JSONEncoding.prettyPrinted
            )
        case .endRecord(_, let walkCount, let distance, let imageUrlString):
            return .requestParameters(
                parameters: [
                    "walk_count": walkCount,
                    "distance": distance,
                    "image_url": imageUrlString
                ],
                encoding: JSONEncoding.prettyPrinted
            )
        case .saveLocations(_, let order, let latitude, let longitude):
            return .requestParameters(
                parameters: [
                    "order": order,
                    "latitude": latitude,
                    "longtiude": longitude
                ],
                encoding: JSONEncoding.prettyPrinted
            )
        case .setExsercises(_, let distance, let walkCount):
            return .requestParameters(
                parameters: [
                    "distance": distance,
                    "walk_count": walkCount
                ],
                encoding: JSONEncoding.prettyPrinted
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
