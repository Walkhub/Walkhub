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
        let newPasseord: String
    }

    struct Output {
    }

    func transform(_ input: Input) -> Output {
        return Output()
    }
}
