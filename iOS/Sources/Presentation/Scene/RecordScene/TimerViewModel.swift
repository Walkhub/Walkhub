import Foundation

import RxSwift
import RxCocoa
import RxFlow

class TimerViewModel: ViewModelType, Stepper {

    private var disposeBag = DisposeBag()
    var steps = PublishRelay<Step>()

    struct Input {
        let move: Driver<Void>
    }

    struct Output {
    }

    func transform(_ input: Input) -> Output {
        input.move.asObservable()
            .map { WalkhubStep.playRecordIsRequired }
            .bind(to: steps)
            .disposed(by: disposeBag)

        return Output()
    }
}
