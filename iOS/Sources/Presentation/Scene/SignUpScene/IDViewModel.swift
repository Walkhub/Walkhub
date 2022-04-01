import Foundation

import RxSwift
import RxCocoa
import Service
import RxFlow

class IDViewModel: ViewModelType, Stepper {

    private let checkAccountIdUseCase: CheckAccountIdUseCase

    init(checkAccountIdUseCase: CheckAccountIdUseCase) {
        self.checkAccountIdUseCase = checkAccountIdUseCase
    }

    var steps = PublishRelay<Step>()
    private var disposeBag = DisposeBag()

    struct Input {
        let id: Driver<String>
        let continueButtonDidTap: Driver<Void>
    }

    struct Output {
    }

    func transform(_ input: Input) -> Output {

        input.continueButtonDidTap
            .asObservable()
            .withLatestFrom(input.id)
            .flatMap {
                self.checkAccountIdUseCase.excute(accountId: $0)
                    .andThen(Single.just(WalkhubStep.passwordIsRequired))
                    .catchAndReturn(WalkhubStep.loaf(
                        "이미 존재하는 아이디에요.",
                        state: .error,
                        location: .bottom))
            }.bind(to: steps)
            .disposed(by: disposeBag)

        return Output()
    }
}
