import Foundation

import RxSwift

public class SynchronizeDailyExerciseRecordUseCase {

    private let exercisesRepository: ExercisesRepository

    init(exercisesRepository: ExercisesRepository) {
        self.exercisesRepository = exercisesRepository
    }

    public func excute() -> Completable {
        exercisesRepository.synchronizeDailyExerciseRecord()
    }

}
