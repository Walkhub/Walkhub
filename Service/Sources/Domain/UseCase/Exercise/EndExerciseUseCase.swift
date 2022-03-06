import Foundation

import RxSwift

public class EndExerciseUseCase {

    private let exerciseRepsitory: ExercisesRepository

    init(exerciseRepository: ExercisesRepository) {
        self.exerciseRepsitory = exerciseRepository
    }

    public func excute() -> Completable {
        return exerciseRepsitory.finishMeasuring(imageUrlString: nil)
    }
}
