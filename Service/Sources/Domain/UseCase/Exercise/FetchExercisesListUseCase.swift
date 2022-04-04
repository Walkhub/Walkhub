import Foundation

import RxSwift

public class FetchExercisesListUseCase {

    private let exercisesRepository: ExercisesRepository

    init(exercisesRepository: ExercisesRepository) {
        self.exercisesRepository = exercisesRepository
    }

    public func excute() -> Observable<[MeasuredExercise]> {
        return exercisesRepository.fetchMeasuredExercises()
    }
}
