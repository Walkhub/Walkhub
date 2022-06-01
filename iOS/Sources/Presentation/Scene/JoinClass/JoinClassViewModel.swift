import Foundation

import RxSwift
import RxCocoa
import RxFlow
import Service

class JoinClassViewModel: ViewModelType, Stepper {

    private let joinClassUseCase: JoinClassUseCase

    init(joinClassUseCase: JoinClassUseCase) {
        self.joinClassUseCase = joinClassUseCase
    }

    var steps = PublishRelay<Step>()
    private var disposeBag = DisposeBag()

    struct Input {
        let joinClassButtonDidTap: Driver<Void>
        let classCode: String
        let classNumber: Driver<String>
    }
    struct Output {
    }

    func transform(_ input: Input) -> Output {
        input.joinClassButtonDidTap
            .asObservable()
            .withLatestFrom(input.classNumber)
            .flatMap {
                self.joinClassUseCase.excute(
                    input.classCode,
                    Int($0) ?? 0
                ).andThen(Single.just(WalkhubStep.backToDetailHubIsScene))
            }.bind(to: steps)
            .disposed(by: disposeBag)

         return Output()
    }
}
