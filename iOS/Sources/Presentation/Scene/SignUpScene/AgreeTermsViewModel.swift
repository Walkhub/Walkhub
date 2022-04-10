// swiftlint:disable superfluous_disable_command
// swiftlint:disable function_body_length

import Foundation

import RxSwift
import RxCocoa
import RxFlow
import Service

class AgreeTermsViewModel: ViewModelType, Stepper {

    private let signupUseCase: SignupUseCase

    init(
        signupUseCase: SignupUseCase
    ) {
        self.signupUseCase = signupUseCase
    }

    private var disposeBag = DisposeBag()
    var steps = PublishRelay<Step>()

    struct Input {
        let name: String
        let phoneNumber: String
        let authCode: String
        let id: String
        let password: String
        let schoolId: Int
        let signupButtonDidTap: Driver<Void>
    }

    struct Output {
    }

    func transform(_ input: Input) -> Output {

        input.signupButtonDidTap
            .asObservable()
            .flatMap {
                return self.signupUseCase.excute(
                    id: input.id,
                    password: input.password,
                    name: input.name,
                    phoneNumber: input.phoneNumber,
                    authCode: input.authCode,
                    schoolId: input.schoolId
                ).andThen(Single.just(WalkhubStep.enterHealthInfoIsRequired))
                    .catchAndReturn(WalkhubStep.loaf("회원가입 실패", state: .error, location: .top))
            }.bind(to: steps)
            .disposed(by: disposeBag)
        return Output()
    }
}
