import Foundation

import RxSwift
import Moya

final class RemoteExercisesDataSource: RestApiRemoteDataSource<ExercisesAPI> {

    static let shared = RemoteExercisesDataSource()

    private override init() { }

    func startMeasuring(
        goal: Int,
        goalType: MeasuringGoalType
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
    ) -> Completable {
        return request(.finishMeasuring(
            exercisesId: exercisesId,
            walkCount: walkCount,
            distance: distance,
            imageUrlString: imageUrlString
        )).asCompletable()
    }

    func saveLocations(
        exercisesId: Int,
        order: Int,
        latitude: String,
        longitude: String
    ) -> Completable {
        return request(.saveLocations(
            exercisesId: exercisesId,
            order: order,
            latitude: latitude,
            longitude: longitude
        )).asCompletable()
    }

    func setExsercises(
        date: String,
        distance: Int,
        walkCount: Int
    ) -> Completable {
        return request(.setExsercises(
            date: date,
            distance: distance,
            walkCount: walkCount
        )).asCompletable()
    }

}
