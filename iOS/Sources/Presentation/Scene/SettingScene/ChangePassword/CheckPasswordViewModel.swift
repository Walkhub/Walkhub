import Foundation

import RxSwift
import RxCocoa
import RxFlow
import Service

class CheckPasswordViewModel: ViewModelType, Stepper {

    private let checkPasswordUseCase: CheckPasswordUseCase

    init(checkPasswordUseCase: CheckPasswordUseCase) {
        self.checkPasswordUseCase = checkPasswordUseCase
    }

    private var disposeBag = DisposeBag()
    var steps = PublishRelay<Step>()

    struct Input {
        let password: Driver<String>
    }

    struct Output {
    }

    func transform(_ input: Input) -> Output {
        input.password.asObservable()
            .flatMap {
                self.checkPasswordUseCase.excute(currentPw: $0)
                    .andThen(Single.just(WalkhubStep.changePasswordScene))
                    .catchAndReturn(WalkhubStep.loaf("비밀번호가 틀렸어요.", state: .error, location: .bottom))
            }.bind(to: steps)
            .disposed(by: disposeBag)

        return Output()
    }
}
