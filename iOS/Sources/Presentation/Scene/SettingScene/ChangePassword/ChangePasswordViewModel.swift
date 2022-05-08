import Foundation

import RxSwift
import RxCocoa
import RxFlow
import Service

class ChangePasswordViewModel: ViewModelType, Stepper {
    private let changePasswordUseCase: ChangePasswordUseCase

    init(changePasswordUseCase: ChangePasswordUseCase) {
        self.changePasswordUseCase = changePasswordUseCase
    }

    var steps = PublishRelay<Step>()
    private var disposeBag = DisposeBag()

    struct Input {
        let currentPassword: String
        let newPasseord: Driver<String>
        let changeButtonDidTap: Driver<Void>
    }

    struct Output {
    }

    func transform(_ input: Input) -> Output {
        input.changeButtonDidTap.asObservable()
            .withLatestFrom(input.newPasseord)
            .flatMap {
                self.changePasswordUseCase.excute(
                    password: input.currentPassword,
                    newPassword: $0
                ).andThen(Single.just(WalkhubStep.backToAccountScene))
                    .catchAndReturn(WalkhubStep.loaf(
                        "비밀번호 변경에 성공하셨습니다.",
                        state: .success,
                        location: .bottom
                    ))
            }.bind(to: steps)
            .disposed(by: disposeBag)

        return Output()
    }
}
