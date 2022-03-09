import Foundation

import RxSwift
import RxCocoa
import Service
import RxFlow

class RecordMeasurementViewModel: ViewModelType, Stepper {

    private let fetchExercisesListUseCase: FetchExercisesListUseCase
    private let startExerciseUseCase: StartExerciseUseCase

    init(
        fetchExercisesListUseCase: FetchExercisesListUseCase,
        startExerciseUseCase: StartExerciseUseCase
    ) {
        self.fetchExercisesListUseCase = fetchExercisesListUseCase
        self.startExerciseUseCase = startExerciseUseCase
    }

    var steps = PublishRelay<Step>()
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
        let info = Driver.combineLatest(input.goal.startWith(0), input.goalType)

        input.getData.asObservable().flatMap {
            self.fetchExercisesListUseCase.excute()
        }.subscribe(onNext: {
            exercisesList.accept($0)
        }).disposed(by: disposeBag)

        input.start.asObservable()
            .throttle(.seconds(1), latest: false, scheduler: MainScheduler.asyncInstance)
            .withLatestFrom(info)
            .flatMap {
                self.startExerciseUseCase.excute(goal: $0, goalType: $1)
                    .andThen(Single.just(WalkhubStep.playRecordIsRequired))
            }
            .bind(to: steps)
            .disposed(by: disposeBag)

        return Output(exercisesList: exercisesList)
    }
}

