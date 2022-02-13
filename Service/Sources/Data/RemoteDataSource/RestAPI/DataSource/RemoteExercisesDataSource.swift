import Foundation

import RxSwift
import Moya

final class RemoteExercisesDataSource: RestApiRemoteDataSource<ExercisesAPI> {

    static let shared = RemoteExercisesDataSource()

    private override init() { }

    func fetchExerciseAnalysis() -> Single<ExerciseAnalysis> {
        return request(.fetchExerciseAnalysis)
            .map(ExerciseAnalysisDTO.self)
            .map { $0.toDomain() }
    }

    func fetchMeasuredExercises() -> Single<[MeasuredExercise]> {
        return request(.fetchMeasuredExercises)
            .map(MeasuredExerciseListDTO.self)
            .map { $0.toDomain() }
    }

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
        imageUrlString: String?
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

    func saveDailyExsercises(
        date: Date,
        distance: Double,
        walkCount: Int,
        calorie: Double
    ) -> Completable {
        return request(.saveDailyExsercises(
            date: date,
            distance: distance,
            walkCount: walkCount,
            calorie: calorie
        )).asCompletable()
    }

}
