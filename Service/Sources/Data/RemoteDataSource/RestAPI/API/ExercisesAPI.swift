import Foundation

import Moya

enum ExercisesAPI {
    case startMeasuring(goal: Int, goalType: String)
    case finishMeasuring(exercisesId: Int, walkCount: Int, distance: Int, imageUrlString: String)
    case saveLocations(exercisesId: Int, order: Int, latitude: String, longitude: String)
    case setExsercises(date: String, distance: Int, walkCount: Int)
}

extension ExercisesAPI: WalkhubAPI {

    var domain: ApiDomain {
        .exercies
    }

    var urlPath: String {
        switch self {
        case .startMeasuring:
            return "/"
        case .finishMeasuring(let exercisesId, _, _, _):
            return "/\(exercisesId)"
        case .saveLocations(let exercisesId, _, _, _):
            return "/locations/\(exercisesId)"
        case .setExsercises(let date, _, _):
            return "?date=\(date)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .startMeasuring, .saveLocations:
            return .post
        case .finishMeasuring:
            return .patch
        default:
            return .put
        }
    }

    var task: Task {
        switch self {
        case .startMeasuring(let goal, let goalType):
            return .requestParameters(
                parameters: [
                    "goal": goal,
                    "goal_type": goalType
                ],
                encoding: JSONEncoding.prettyPrinted
            )
        case .finishMeasuring(_, let walkCount, let distance, let imageUrlString):
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
