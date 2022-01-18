import Foundation

import RxSwift
import Moya

final class ExercisesService: BaseService<ExercisesAPI> {
    
    static let shared = ExercisesService()
    
    private override init() {}
    
    func startRecord(
        goal: Int,
        goalType: String
    ) -> Single<Response> {
        return request(.startRecord(
            goal: goal,
            goalType: goalType
        ))
    }
    
    func endRecord(
        exercisesID: Int,
        walkCount: Int,
        distance: Int,
        imageUrlString: String
    ) -> Single<Response> {
        return request(.endRecord(
            exercisesID: exercisesID,
            walkCount: walkCount,
            distance: distance,
            imageUrlString: imageUrlString
        ))
    }
    
    func getLocations(
        exercisesID: Int,
        order: Int,
        latitude: String,
        longitude: String
    ) -> Single<Response> {
        return request(.getLocations(
            exercisesID: exercisesID,
            order: order,
            latitude: latitude,
            longitude: longitude
        ))
    }
    
    func setExsercises(
        date: String,
        distance: Int,
        walkCount: Int
    ) -> Single<Response> {
        return request(.setExsercises(
            date: date,
            distance: distance,
            walkCount: walkCount
        ))
    }
}
