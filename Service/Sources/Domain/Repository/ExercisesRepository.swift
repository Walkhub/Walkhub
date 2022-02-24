import Foundation

import RxSwift

protocol ExercisesRepository {
    func fetchLiveDailyExerciseRecord() -> Observable<DailyExerciseRecord>
    func fetchLiveMeasuringExerciseRecord() -> Observable<MeasuringExerciseRecord>
    func synchronizeDailyExerciseRecord() -> Completable
    func fetchExerciseAnalysis() -> Observable<ExerciseAnalysis>
    func fetchMeasuredExercises() -> Observable<[MeasuredExercise]>
    func startMeasuring(goal: Int, goalType: ExerciseGoalType) -> Completable
    func finishMeasuring(imageUrlString: String?) -> Completable
}
