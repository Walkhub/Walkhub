import Foundation

import RxCocoa
import RxFlow
import RxSwift

class AppStepper: Stepper {

    var steps = PublishRelay<Step>()
    private let disposeBag = DisposeBag()

    func readyToEmitSteps() {
        // TODO: 로그인 필요 유무 판한후 steps에 관련 step accept
        sleep(3)
        steps.accept(WalkhubStep.tabsIsRequired)
    }

}
