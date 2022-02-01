import Foundation

import RxSwift
import Moya

final class RemoteExercisesDataSource: RestApiRemoteDataSource<ExercisesAPI> {

    static let shared = RemoteExercisesDataSource()

    private override init() { }

    func startRecord(
        goal: Int,
        goalType: String
    ) -> Single<String> {
        return request(.startRecord(
            goal: goal,
            goalType: goalType
        ))
            .map(ExerciseIdDTO.self)
            .map { $0.toDomain() }
    }

    func endRecord(
        exercisesID: Int,
        walkCount: Int,
        distance: Int,
        imageUrlString: String
    ) -> Single<Void> {
        return request(.endRecord(
            exercisesID: exercisesID,
            walkCount: walkCount,
            distance: distance,
            imageUrlString: imageUrlString
        )).map { _ in () }
    }

    func saveLocations(
        exercisesID: Int,
        order: Int,
        latitude: String,
        longitude: String
    ) -> Single<Void> {
        return request(.saveLocations(
            exercisesID: exercisesID,
            order: order,
            latitude: latitude,
            longitude: longitude
        )).map { _ in () }
    }

    func setExsercises(
        date: String,
        distance: Int,
        walkCount: Int
    ) -> Single<Void> {
        return request(.setExsercises(
            date: date,
            distance: distance,
            walkCount: walkCount
        )).map { _ in () }
    }

}
