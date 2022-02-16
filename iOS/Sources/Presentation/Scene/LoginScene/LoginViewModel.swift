import Foundation

import RxCocoa
import RxFlow
import RxSwift
import Service

class LoginViewModel: ViewModelType, Stepper {

    private let signinUseCase: SigninUseCase

    private let disposeBag = DisposeBag()
    var steps = PublishRelay<Step>()

    var output = Output()

    init(signinUseCase: SigninUseCase) {
        self.signinUseCase = signinUseCase
    }

    struct Input {
        let idTextfieldString: Driver<String>
        let passwordTextfieldString: Driver<String>
        let loginButtonIsTapped: Driver<Void>
        let findIdButtonIsTapped: Driver<Void>
        let changePasswordButtonIsTapped: Driver<Void>
    }

    struct Output {
    }

    func transform(_ input: Input) -> Output {

        input.findIdButtonIsTapped
            .asObservable()
            .map { WalkhubStep.findIdIsRequired }
            .bind(to: steps)
            .disposed(by: disposeBag)

        input.changePasswordButtonIsTapped
            .asObservable()
            .map { WalkhubStep.changePasswordIsRequired }
            .bind(to: steps)
            .disposed(by: disposeBag)

        input.loginButtonIsTapped
            .asObservable()
            .flatMap {
                Observable.zip(
                    input.idTextfieldString.asObservable().take(1),
                    input.passwordTextfieldString.asObservable().take(1)
                ) { (id: $0, password: $1) }
            }
            .flatMap {
                self.signinUseCase.excute(id: $0.id, password: $0.password)
                    .do(onError: {
                        print("ERROR \($0)")
                    }, onCompleted: {
                        print("SUCCESS")
                    })
                    .andThen(Single.just(WalkhubStep.userIsLoggedIn))
                    .catchAndReturn(WalkhubStep.loaf("로그인 실패", state: .error, location: .top))
            }
            .bind(to: steps)
            .disposed(by: disposeBag)

        return output
    }

}
