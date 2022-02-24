import Foundation

import Moya

enum ExercisesAPI {
    case fetchExerciseAnalysis
    case fetchMeasuredExercises
    case startMeasuring(goal: Int, goalType: ExerciseGoalType)
    case finishMeasuring(exercisesId: Int, walkCount: Int, distance: Int, imageUrlString: String?)
    case saveLocations(exercisesId: Int, locationList: [UserLocation])
    case saveDailyExsercises(date: Date, distance: Double, walkCount: Int, calorie: Double)
}

extension ExercisesAPI: WalkhubAPI {

    var domain: ApiDomain {
        .exercises
    }

    var urlPath: String {
        switch self {
        case .fetchExerciseAnalysis:
            return "/analysis"
        case .fetchMeasuredExercises:
            return "/lists"
        case .startMeasuring:
            return "/"
        case .finishMeasuring(let exercisesId, _, _, _):
            return "/\(exercisesId)"
        case .saveLocations(let exercisesId, _):
            return "/locations/\(exercisesId)"
        case .saveDailyExsercises:
            return "/"
        }
    }

    var method: Moya.Method {
        switch self {
        case .fetchExerciseAnalysis, .fetchMeasuredExercises:
            return .get
        case .startMeasuring, .saveLocations:
            return .post
        case .finishMeasuring:
            return .patch
        case .saveDailyExsercises:
            return .put
        }
    }

    var task: Task {
        switch self {
        case .startMeasuring(let goal, let goalType):
            return .requestParameters(
                parameters: [
                    "goal": goal,
                    "goal_type": goalType.rawValue
                ],
                encoding: JSONEncoding.prettyPrinted
            )
        case .finishMeasuring(_, let walkCount, let distance, let imageUrlString):
            return .requestParameters(
                parameters: [
                    "walk_count": walkCount,
                    "distance": distance,
                    "image_url": imageUrlString ?? NSNull()
                ],
                encoding: JSONEncoding.prettyPrinted
            )
        case .saveLocations(_, let locationList):
            return .requestParameters(
                parameters: [
                    "location_list": [
                        locationList
                            .enumerated()
                            .map {
                                return [
                                    "sequence": $0.0 + 1,
                                    "latitude": $0.1.latitude,
                                    "longitude": $0.1.longitude
                                ]
                            }
                    ]
                ],
                encoding: JSONEncoding.prettyPrinted
            )
        case .saveDailyExsercises(let date, let distance, let walkCount, let calorie):
            return .requestParameters(
                parameters: [
                    "distance": distance,
                    "walk_count": walkCount,
                    "date": date.toDateString(),
                    "calorie": calorie
                ],
                encoding: JSONEncoding.prettyPrinted
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
