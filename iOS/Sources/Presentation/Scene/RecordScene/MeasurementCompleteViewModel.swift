import Foundation

import RxSwift
import RxCocoa
import Service
import RxFlow

class MeasurementCompleteViewModel: ViewModelType, Stepper {

    private let fetchExercisesListUseCase: FetchExercisesListUseCase

    init(
        fetchExercisesListUseCase: FetchExercisesListUseCase
    ) {
        self.fetchExercisesListUseCase = fetchExercisesListUseCase
    }

    var steps = PublishRelay<Step>()
    private var disposeBag = DisposeBag()

    struct Input {
        let getData: Driver<Void>
    }

    struct Output {
        let exercisesList: PublishRelay<[MeasuredExercise]>
    }

    func transform(_ input: Input) -> Output {
        let exercisesList = PublishRelay<[MeasuredExercise]>()

        input.getData.asObservable().flatMap {
            self.fetchExercisesListUseCase.excute()
        }.subscribe(onNext: {
            exercisesList.accept($0)
        }).disposed(by: disposeBag)

        return Output(exercisesList: exercisesList)
    }
}
