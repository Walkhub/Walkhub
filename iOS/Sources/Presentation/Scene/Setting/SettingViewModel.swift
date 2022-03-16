import Foundation

import RxSwift
import RxCocoa
import RxFlow

class SettingViewModel: ViewModelType, Stepper {

    private var disposeBag = DisposeBag()

    var steps = PublishRelay<Step>()

    struct Input {
        let navigateToEditProfileScene: Driver<Void>
        let navigateToEditHealthInformationScene: Driver<Void>
        let navigateToAccountInformationScene: Driver<Void>
    }

    struct Output {
    }

    func transform(_ input: Input) -> Output {

        input.navigateToEditProfileScene.asObservable()
            .map { WalkhubStep.editProfileIsRequired }
            .bind(to: steps)
            .disposed(by: disposeBag)

        input.navigateToEditHealthInformationScene.asObservable()
            .map { WalkhubStep.editHealthInformationIsRequired }
            .bind(to: steps)
            .disposed(by: disposeBag)

        return Output()
    }
}
