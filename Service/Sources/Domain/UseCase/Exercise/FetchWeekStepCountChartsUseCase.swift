import Foundation

import RxSwift

public class FetchWeekStepCountChartsUseCase {
    private let exercisesRepository: ExercisesRepository

    init(exerisesRepository: ExercisesRepository) {
        self.exercisesRepository = exerisesRepository
    }

    public func excute() -> Observable<([Int], Int, Int)> {
        return exercisesRepository.fetchExerciseAnalysis()
                    .map { $0.walkCountList }
                    .map { $0.reversed() }
                    .map { Array($0[0..<7]) }
                    .map { $0.reversed() }
                    .map { data -> ([Int], Int, Int) in
                        var allStepCount: Int = 0
                        for num in data {
                            allStepCount += num
                        }
                        return (Array(data), allStepCount, allStepCount / data.count)
                    }
    }
}
