import Foundation

import RxSwift

public class FetchCalroiesLevelUseCase {

    private let levelRepository: LevelRepository
    private let exercisesRepository: ExercisesRepository

    init(
        levelRepository: LevelRepository,
        exercisesRepository: ExercisesRepository
    ) {
        self.levelRepository = levelRepository
        self.exercisesRepository = exercisesRepository
    }

    public func excute() -> Observable<CaloriesLevel> {
        return exercisesRepository.fetchLiveDailyExerciseRecord()
            .flatMap { [weak self] exerciseRecord in
                (self?.levelRepository.fetchCaloriesLevelList()
                    .map { level in
                    level.first { data in
                        Int(exerciseRecord.burnedKilocalories) < data.calorie
                    } ?? level.last!
                })!
            }
    }
}
