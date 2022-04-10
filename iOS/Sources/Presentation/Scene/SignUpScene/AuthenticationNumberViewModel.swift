import Foundation

import RxSwift
import RxCocoa
import RxFlow
import Service

class AuthenicationNumberViewModel: ViewModelType, Stepper {

    private let checkVerificationCodeUseCase: CheckVerificationCodeUseCase
    private let verificationPhoneUseCase: VerificationPhoneUseCase

    init(
        checkVerificationCodeUseCase: CheckVerificationCodeUseCase,
        verificationPhoneUseCase: VerificationPhoneUseCase
    ) {
        self.checkVerificationCodeUseCase = checkVerificationCodeUseCase
        self.verificationPhoneUseCase = verificationPhoneUseCase
    }

    var steps = PublishRelay<Step>()
    private var disposeBag = DisposeBag()

    struct Input {
        let name: String
        let phoneNumber: String
        let authCode: Driver<String>
        let continueButtonDidTap: Driver<Void>
        let checkButtonDidTap: Driver<Void>
    }

    struct Output {
    }

    func transform(_ input: Input) -> Output {

        input.continueButtonDidTap
            .asObservable()
            .withLatestFrom(input.authCode)
            .flatMap {
                self.checkVerificationCodeUseCase.excute(
                    verificationCode: $0,
                    phoneNumber: input.phoneNumber
                ).andThen(Single.just(WalkhubStep.enterIdRequired(
                    name: input.name,
                    phoneNumber: input.phoneNumber,
                    authCode: $0
                )))
                    .catchAndReturn(WalkhubStep.loaf(
                        "인증번호가 일치하지 않습니다.",
                        state: .error,
                        location: .top
                    ))
            }.bind(to: steps)
            .disposed(by: disposeBag)

        input.checkButtonDidTap
            .asObservable()
            .flatMap {
                self.verificationPhoneUseCase.excute(phoneNumber: input.phoneNumber)
            }.subscribe(onNext: { _ in
            }).disposed(by: disposeBag)

        return Output()
    }
}
