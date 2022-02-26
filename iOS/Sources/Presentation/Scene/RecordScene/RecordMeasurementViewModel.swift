import Foundation

import RxSwift
import RxCocoa
import Service

class RecordMeasurementViewModel: ViewModelType {

    private let fetchExercisesListUseCase: FetchExercisesListUseCase
    private let startExerciseUseCase: StartExerciseUseCase

    init(
        fetchExercisesListUseCase: FetchExercisesListUseCase,
        startExerciseUseCase: StartExerciseUseCase
    ) {
        self.fetchExercisesListUseCase = fetchExercisesListUseCase
        self.startExerciseUseCase = startExerciseUseCase
    }

    private var disposeBag = DisposeBag()

    struct Input {
        let getData: Driver<Void>
        let goal: Driver<Int>
        let goalType: Driver<ExerciseGoalType>
        let start: Driver<Void>
    }

    struct Output {
        let exercisesList: PublishRelay<[MeasuredExercise]>
    }

    func transform(_ input: Input) -> Output {
        let exercisesList = PublishRelay<[MeasuredExercise]>()
        let info = Driver.combineLatest(input.goal, input.goalType)

        input.getData.asObservable().flatMap {
            self.fetchExercisesListUseCase.excute()
        }.subscribe(onNext: {
            exercisesList.accept($0)
        }).disposed(by: disposeBag)

        input.start.asObservable().withLatestFrom(info).flatMap { goal, goalType in
            self.startExerciseUseCase.excute(goal: goal, goalType: goalType)
        }.subscribe(onNext: { _ in
        }).disposed(by: disposeBag)

        return Output(exercisesList: exercisesList)
    }
}
