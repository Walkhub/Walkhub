import Foundation

import RxSwift

public class FetchExerciseAnalysisUseCase {
    private let exerciseRepository: ExercisesRepository

    init(exerciseRepository: ExercisesRepository) {
        self.exerciseRepository = exerciseRepository
    }

    public func excute() -> Observable<ExerciseAnalysis> {
        return self.exerciseRepository.fetchExerciseAnalysis()
    }
}
