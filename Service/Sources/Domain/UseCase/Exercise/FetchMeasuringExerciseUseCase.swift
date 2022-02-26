import Foundation

import RxSwift

public class FetchMeasuringExerciseUseCase {

    private let exerciseRepository: ExercisesRepository

    init(exerciseRepository: ExercisesRepository) {
        self.exerciseRepository = exerciseRepository
    }

    public func excute() -> Observable<MeasuringExerciseRecord> {
        return exerciseRepository.fetchLiveMeasuringExerciseRecord()
    }
}
