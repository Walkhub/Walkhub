import Foundation

import RxSwift
import Moya

final class RemoteExercisesDataSource: RestApiRemoteDataSource<ExercisesAPI> {

    static let shared = RemoteExercisesDataSource()

    private override init() { }

    func startMeasuring(
        goal: Int,
        goalType: String
    ) -> Single<Int> {
        return request(.startMeasuring(
            goal: goal,
            goalType: goalType
        ))
            .map(ExercisesIdDTO.self)
            .map { $0.toDomain() }
    }

    func finishMeasuring(
        exercisesId: Int,
        walkCount: Int,
        distance: Int,
        imageUrlString: String
    ) -> Single<Void> {
        return request(.finishMeasuring(
            exercisesId: exercisesId,
            walkCount: walkCount,
            distance: distance,
            imageUrlString: imageUrlString
        )).map { _ in () }
    }

    func saveLocations(
        exercisesId: Int,
        order: Int,
        latitude: String,
        longitude: String
    ) -> Single<Void> {
        return request(.saveLocations(
            exercisesId: exercisesId,
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
