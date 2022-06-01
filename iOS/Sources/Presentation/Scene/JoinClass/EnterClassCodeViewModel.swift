import Foundation

import RxSwift
import RxCocoa
import RxFlow
import Service

class EnterClassCodeViewModel: ViewModelType, Stepper {
    private let checkClassCodeUseCase: CheckClassCodeUseCase

    init(checkClassCodeUseCase: CheckClassCodeUseCase) {
        self.checkClassCodeUseCase = checkClassCodeUseCase
    }

    private var disposeBag = DisposeBag()
    var steps = PublishRelay<Step>()

    struct Input {
        let joinButtonDidTap: Driver<Void>
        let classCode: Driver<String>
    }
    struct Output {
        let error: PublishRelay<Bool>
    }

    func transform(_ input: Input) -> Output {

        let error = PublishRelay<Bool>()
        input.joinButtonDidTap
            .asObservable()
            .withLatestFrom(input.classCode)
            .flatMap {
                self.checkClassCodeUseCase.excute($0)
                    .andThen(Single.just(WalkhubStep.joinClassIsRequired($0)))
                    .catch {_ in
                        error.accept(false)
                        return Single.just(WalkhubStep.none)
                    }
            }.bind(to: steps)
            .disposed(by: disposeBag)

        return Output(error: error)
    }
}
