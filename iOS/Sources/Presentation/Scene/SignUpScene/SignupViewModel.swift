// swiftlint:disable superfluous_disable_command
// swiftlint:disable function_body_length

import Foundation

import RxSwift
import RxCocoa
import RxFlow
import Service

class SignUpViewModel: ViewModelType, Stepper {

    private let signupUseCase: SignupUseCase

    init(signupUseCase: SignupUseCase) {
        self.signupUseCase = signupUseCase
    }

    private var disposeBag = DisposeBag()
    var steps = PublishRelay<Step>()

    struct Input {
        let id: Driver<String>
        let password: Driver<String>
        let name: Driver<String>
        let phoneNumber: Driver<String>
        let authCode: Driver<String>
        let height: Driver<String>
        let weight: Driver<String>
        let sex: Driver<Sex>
        let schoolId: Driver<Int>
        let signupButtonDidTap: Driver<Void>
        let toLaterButtonDidTap: Driver<Void>
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
                    Driver.zip(
                        input.height,
                        input.weight,
                        input.sex
                    ),
                    input.schoolId
                ) { ( SignUpInformation(
                    id: $0,
                    password: $1,
                    name: $2,
                    phoneNum: $3,
                    authCode: $4,
                    height: $5.0,
                    weight: $5.1,
                    sex: $5.2,
                    schoolId: $6
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
                    height: Float($0.height) ?? 0.0,
                    weight: Int($0.weight) ?? 0,
                    sex: $0.sex,
                    schoolId: $0.schoolId
                )
            }.subscribe(onNext: { _ in
            }).disposed(by: disposeBag)

        input.toLaterButtonDidTap
            .asObservable()
            .flatMap {
                Driver.zip(
                    input.id,
                    input.password,
                    input.name,
                    input.phoneNumber,
                    input.authCode,
                    input.schoolId
                ) { (id: $0, pw: $1, name: $2, phoneNum: $3, authCode: $4, schoolId: $5) }
            }.flatMap {
                self.signupUseCase.excute(
                    id: $0.id,
                    password: $0.pw,
                    name: $0.name,
                    phoneNumber: $0.phoneNum,
                    authCode: $0.authCode,
                    height: nil,
                    weight: nil,
                    sex: .noAnswer,
                    schoolId: $0.schoolId
                )
            }.subscribe(onNext: { _ in
            }).disposed(by: disposeBag)
        return Output()
    }
}

struct SignUpInformation {
    let id: String
    let password: String
    let name: String
    let phoneNum: String
    let authCode: String
    let height: String
    let weight: String
    let sex: Sex
    let schoolId: Int
}
