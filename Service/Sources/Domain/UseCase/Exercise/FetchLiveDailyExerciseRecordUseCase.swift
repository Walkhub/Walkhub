import Foundation

import RxSwift

public class FetchLiveDailyExerciseRecordUseCase {
    private let exerciseRepository: ExercisesRepository

    init(exerciseRepository: ExercisesRepository) {
        self.exerciseRepository = exerciseRepository
    }

    public func excute() -> Observable<DailyExerciseRecord> {
        return exerciseRepository.fetchLiveDailyExerciseRecord()
    }
}
