import Foundation

import RxSwift
import RxCocoa
import RxFlow
import Service

class CertifyPhoneNumberViewModel: ViewModelType, Stepper {

    private let verificationPhoneUseCase: VerificationPhoneUseCase

    init(
        verificationPhoneUseCase: VerificationPhoneUseCase
    ) {
        self.verificationPhoneUseCase = verificationPhoneUseCase
    }

    var steps = PublishRelay<Step>()
    var phoneNumber = String()
    private var disposeBag = DisposeBag()

    struct Input {
        let phoneNumber: Driver<String>
        let continueButtonDidTap: Driver<Void>
        let name: String
    }

    struct Output {
    }

    func transform(_ input: Input) -> Output {

        input.phoneNumber.asObservable()
            .subscribe(onNext: {
                self.phoneNumber = $0.components(separatedBy: [" "]).joined()
            }).disposed(by: disposeBag)

        input.continueButtonDidTap
            .asObservable()
            .flatMap {
                self.verificationPhoneUseCase.excute(phoneNumber: self.phoneNumber)
                    .andThen(Single.just(WalkhubStep.authenticationNumberIsRequired(
                        name: input.name,
                        phoneNumber: self.phoneNumber
                    )))
            }.bind(to: steps)
            .disposed(by: disposeBag)

        return Output()
    }
}
