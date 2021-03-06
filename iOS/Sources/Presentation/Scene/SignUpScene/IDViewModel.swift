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
        let name: String
        let phoneNumber: String
        let authCode: String
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
                    .andThen(Single.just(WalkhubStep.passwordIsRequired(
                        name: input.name,
                        phoneNumber: input.phoneNumber,
                        authCode: input.authCode,
                        id: $0
                    )))
                    .catchAndReturn(WalkhubStep.loaf(
                        "이미 존재하는 아이디에요.",
                        state: .error,
                        location: .bottom
                    ))
            }.bind(to: steps)
            .disposed(by: disposeBag)

        return Output()
    }
}
