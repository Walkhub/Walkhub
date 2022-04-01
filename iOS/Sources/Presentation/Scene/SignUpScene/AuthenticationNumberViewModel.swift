import Foundation

import RxSwift
import RxCocoa
import RxFlow
import Service

class AuthenticationNumberViewModel: ViewModelType, Stepper {

    private let checkVerificationCodeUseCase: CheckVerificationCodeUseCase

    init(checkVerificationCodeUseCase: CheckVerificationCodeUseCase) {
        self.checkVerificationCodeUseCase = checkVerificationCodeUseCase
    }

    private var disposeBag = DisposeBag()
    var steps = PublishRelay<Step>()

    struct Input {
        let phoneNumber: Driver<String>
        let authenticationNumber: Driver<String>
        let continueButtonDidTap: Driver<Void>
    }

    struct Output {
    }

    func transform(_ input: Input) -> Output {

        input.continueButtonDidTap
            .asObservable()
            .flatMap {
                Observable.zip(
                    input.phoneNumber.asObservable(),
                    input.authenticationNumber.asObservable()
                ) { (phoneNumber: $0, authenticationNumber: $1) }
            }.flatMap {
                self.checkVerificationCodeUseCase.excute(
                    verificationCode: $0.authenticationNumber,
                    phoneNumber: $0.phoneNumber
                ).andThen(Single.just(WalkhubStep.enterIdRequired))
            }.bind(to: steps)
            .disposed(by: disposeBag)
        return Output()
    }
}
