import Foundation

import RxSwift

public class FetchMonthStepCountChartsUseCase {

    private let exercisesRepository: ExercisesRepository

    init(exercisesRepository: ExercisesRepository) {
        self.exercisesRepository = exercisesRepository
    }

    public func excute() -> Observable<([Int], Int, Int)> {
        return exercisesRepository.fetchExerciseAnalysis()
            .map { data -> ([Int], Int, Int) in
                var allStepCount: Int = 0
                for num in data.walkCountList {
                    allStepCount += num
                }
                return (data.walkCountList, allStepCount, allStepCount / data.walkCountList.count)
            }
    }
}
