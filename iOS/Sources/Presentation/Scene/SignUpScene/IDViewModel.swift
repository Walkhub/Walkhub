import Foundation

import RxSwift
import RxCocoa
import RxFlow
import Service

class IDViewModel: ViewModelType, Stepper {

    private let checkAccountIdUseCase: CheckAccountIdUseCase

    init(checkAccountIdUseCase: CheckAccountIdUseCase) {
        self.checkAccountIdUseCase = checkAccountIdUseCase
    }

    private var disposeBag = DisposeBag()
    var steps = PublishRelay<Step>()

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
                return self.checkAccountIdUseCase.excute(accountId: $0)
                    .andThen(Single.just(WalkhubStep.passwordIsRequired))
                    .catchAndReturn(WalkhubStep.loaf(
                        "이미 존재하는 아이디에요.",
                        state: .info,
                        location: .bottom
                    ))
            }.bind(to: steps)
            .disposed(by: disposeBag)

        return Output()
    }
}
