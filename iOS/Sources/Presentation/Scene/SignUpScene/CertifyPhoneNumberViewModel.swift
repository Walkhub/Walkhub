import Foundation

import RxSwift
import RxCocoa
import RxFlow
import Service

class CertifyPhoneNumberViewModel: ViewModelType, Stepper {

    private let verificationPhoneUseCase: VerificationPhoneUseCase

    init(verificationPhoneUseCase: VerificationPhoneUseCase) {
        self.verificationPhoneUseCase = verificationPhoneUseCase
    }

    var steps = PublishRelay<Step>()
    private var disposeBag = DisposeBag()

    struct Input {
        let phoneNumber: Driver<String>
        let continueButtonDidTap: Driver<Void>
    }

    struct Output {
    }

    func transform(_ input: Input) -> Output {

        input.continueButtonDidTap
            .asObservable()
            .withLatestFrom(input.phoneNumber)
            .flatMap {
                self.verificationPhoneUseCase.excute(phoneNumber: $0)
                    .andThen(Single.just(WalkhubStep.authenticationNumberIsRequired(phoneNumber: $0)))
            }.bind(to: steps)
            .disposed(by: disposeBag)

        return Output()
    }
}
