import Foundation

import RxCocoa
import RxFlow
import RxSwift
import Service

class AppStepper: Stepper {

    private let checkIsSigninedUseCase: CheckIsSigninedUseCase

    var steps = PublishRelay<Step>()
    private let disposeBag = DisposeBag()

    init() {
        self.checkIsSigninedUseCase = AppDelegate.continer.resolve(CheckIsSigninedUseCase.self)!
    }

    func readyToEmitSteps() {
        checkIsSigninedUseCase.excute()
            .andThen(Single.just(WalkhubStep.tabsIsRequired))
            .asObservable()
            .catchAndReturn(WalkhubStep.onboardingIsRequired)
            .bind(to: steps)
            .disposed(by: disposeBag)
    }

}
