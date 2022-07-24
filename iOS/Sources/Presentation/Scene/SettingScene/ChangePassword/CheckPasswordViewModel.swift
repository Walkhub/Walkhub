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
        let contineButtonDidTap: Driver<Void>
    }

    struct Output {
    }

    func transform(_ input: Input) -> Output {
        input.contineButtonDidTap.asObservable()
            .withLatestFrom(input.password)
            .flatMap {
                self.checkPasswordUseCase.excute(currentPw: $0)
                    .andThen(Single.just(WalkhubStep.changePasswordScene(pw: $0)))
                    .catchAndReturn(WalkhubStep.loaf(
                        "비밀번호가 일치하지 않습니다.",
                        state: .error,
                        location: .bottom
                    ))
            }.bind(to: steps)
            .disposed(by: disposeBag)

        return Output()
    }
}
