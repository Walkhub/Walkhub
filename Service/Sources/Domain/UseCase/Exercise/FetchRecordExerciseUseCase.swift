import Foundation

import RxSwift

public class FetchRecordExerciseUseCase {

    private let exerciseRepository: ExercisesRepository

    init(exerciseRepository: ExercisesRepository) {
        self.exerciseRepository = exerciseRepository
    }

    public func excute() -> Single<RecordExercise> {
        return exerciseRepository.fetchRecordExercise()
    }
}
