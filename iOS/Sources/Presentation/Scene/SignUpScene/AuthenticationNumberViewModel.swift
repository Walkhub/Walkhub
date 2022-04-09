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
        let phoneNumber: Driver<String>
        let authCode: Driver<String>
        let continueButtonDidTap: Driver<Void>
        let checkButtonDidTap: Driver<Void>
    }

    struct Output {
    }

    func transform(_ input: Input) -> Output {
        let info = Driver.combineLatest(input.phoneNumber, input.authCode)

        input.continueButtonDidTap
            .asObservable()
            .withLatestFrom(info)
            .flatMap {
                self.checkVerificationCodeUseCase.excute(
                    verificationCode: data.1,
                    phoneNumber: data.0
                ).andThen(Single.just(WalkhubStep.enterIdRequired))
                    .catchAndReturn(WalkhubStep.loaf(
                        "인증번호가 일치하지 않습니다.",
                        state: .error,
                        location: .top
                    ))
            }.bind(to: steps)
            .disposed(by: disposeBag)

        input.checkButtonDidTap
            .asObservable()
            .withLatestFrom(input.phoneNumber)
            .flatMap {
                self.verificationPhoneUseCase.excute(phoneNumber: $0)
            }.subscribe(onNext: { _ in
            }).disposed(by: disposeBag)

        return Output()
    }
}
