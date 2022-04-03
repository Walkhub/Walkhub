// swiftlint:disable superfluous_disable_command
// swiftlint:disable function_body_length

import Foundation

import RxSwift
import RxCocoa
import RxFlow
import Service

class AgreeTermsViewModel: ViewModelType, Stepper {

    private let signupUseCase: SignupUseCase
    private let signinUseCase: SigninUseCase

    init(
        signupUseCase: SignupUseCase,
        signinUseCase: SigninUseCase
    ) {
        self.signupUseCase = signupUseCase
        self.signinUseCase = signinUseCase
    }

    private var disposeBag = DisposeBag()
    var steps = PublishRelay<Step>()

    struct Input {
        let id: Driver<String>
        let password: Driver<String>
        let name: Driver<String>
        let phoneNumber: Driver<String>
        let authCode: Driver<String>
        let schoolId: Driver<Int>
        let signupButtonDidTap: Driver<Void>
        let signinButtonDidTap: Driver<Void>
    }

    struct Output {
    }

    func transform(_ input: Input) -> Output {

        input.signupButtonDidTap
            .asObservable()
            .flatMap { () -> Driver<SignUpInformation> in
                let driver: Driver<SignUpInformation> = Driver.zip(
                    input.id,
                    input.password,
                    input.name,
                    input.phoneNumber,
                    input.authCode,
                    input.schoolId
                ) { ( SignUpInformation(
                    id: $0,
                    password: $1,
                    name: $2,
                    phoneNum: $3,
                    authCode: $4,
                    schoolId: $5
                )
                )}
                return driver
            }.flatMap {
                self.signupUseCase.excute(
                    id: $0.id,
                    password: $0.password,
                    name: $0.name,
                    phoneNumber: $0.phoneNum,
                    authCode: $0.authCode,
                    height: 0.0,
                    weight: 0,
                    sex: .noAnswer,
                    schoolId: $0.schoolId
                ).andThen(Single.just(WalkhubStep.homeIsRequired))
            }.subscribe(onNext: { _ in
            }).disposed(by: disposeBag)

        input.signinButtonDidTap
            .asObservable()
            .flatMap {
                Observable.zip(
                    input.id.asObservable(),
                    input.password.asObservable()
                ) { (id: $0, pw: $1)}
            }.flatMap {
                self.signinUseCase.excute(id: $0.id, password: $0.pw)
                    .andThen(Single.just(WalkhubStep.homeIsRequired))
            }.bind(to: steps)
            .disposed(by: disposeBag)

        return Output()
    }
}

struct SignUpInformation {
    let id: String
    let password: String
    let name: String
    let phoneNum: String
    let authCode: String
    let schoolId: Int
}
