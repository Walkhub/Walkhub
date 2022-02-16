import Foundation

import RxCocoa
import RxFlow
import RxSwift
import Service

class LoginViewModel: ViewModelType, Stepper {

    private let signinUseCase: SigninUseCase

    private let disposeBag = DisposeBag()
    var steps = PublishRelay<Step>()

    init(signinUseCase: SigninUseCase) {
        self.signinUseCase = signinUseCase
    }

    struct Input {
    }

    struct Output {
    }

    func transform(_ input: Input) -> Output {
        return Output()
    }

}
