import Foundation

import RxSwift
import RxCocoa
import RxFlow

class AccountInformationViewModel: ViewModelType, Stepper {

    private var disposeBag = DisposeBag()
    var steps = PublishRelay<Step>()

    struct Input {
    }

    struct Output {
    }

    func transform(_ input: Input) -> Output {
        return Output()
    }
}
