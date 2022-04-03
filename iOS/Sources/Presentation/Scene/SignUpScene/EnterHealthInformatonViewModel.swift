import Foundation

import RxSwift
import RxCocoa
import RxFlow
import Service

class EnterHealthInformationViewModel: ViewModelType, Stepper {

    private let setHealthInformationUseCase: SetHealthInformationUseCase

    init(setHealthInformationUseCase: SetHealthInformationUseCase) {
        self.setHealthInformationUseCase = setHealthInformationUseCase
    }

    private var disposeBag = DisposeBag()
    var steps = PublishRelay<Step>()

    struct Input {
        let height: Driver<String>
        let weight: Driver<String>
        let sex: Driver<Sex>
        let completeButtonDidTap: Driver<Void>
        let doLaterButtonDidTap: Driver<Void>
    }

    struct Output {
    }

    func transform(_ input: Input) -> Output {

        input.completeButtonDidTap
            .asObservable()
            .flatMap {
                Observable.zip(
                    input.height.asObservable(),
                    input.weight.asObservable(),
                    input.sex.asObservable()
                ) { (height: $0, weight: $1, sex: $2) }
            }.flatMap {
                self.setHealthInformationUseCase.excute(
                    height: Float($0.height) ?? 0.0,
                    weight: Int($0.weight) ?? 0,
                    sex: $0.sex
                ).andThen(Single.just(WalkhubStep.homeIsRequired))
            }.bind(to: steps)
            .disposed(by: disposeBag)

        input.doLaterButtonDidTap
            .asObservable()
            .map { WalkhubStep.homeIsRequired }
            .bind(to: steps)
            .disposed(by: disposeBag)

        return Output()
    }
}
