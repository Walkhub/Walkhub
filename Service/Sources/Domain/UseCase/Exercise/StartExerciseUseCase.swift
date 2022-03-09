import Foundation

import RxSwift

public class StartExerciseUseCase {

    private let exercisesRepository: ExercisesRepository

    init(exercisesRepository: ExercisesRepository) {
        self.exercisesRepository = exercisesRepository
    }

    public func excute(
        goal: Int,
        goalType: ExerciseGoalType
    ) -> Completable {
        return exercisesRepository.startMeasuring(
            goal: goal,
            goalType: goalType
        )
    }
}
