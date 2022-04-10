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
        let info = Driver.combineLatest(input.height, input.weight, input.sex)

        input.completeButtonDidTap
            .asObservable()
            .withLatestFrom(info)
            .flatMap {
                return self.setHealthInformationUseCase.excute(
                    height: Double($0),
                    weight: Int(Double($1) ?? 1),
                    sex: $2
                ).andThen(Single.just(WalkhubStep.tabsIsRequired))
            }.subscribe(onNext: {
                self.steps.accept($0)
            }).disposed(by: disposeBag)

        steps.asObservable()
            .subscribe(onNext: { _ in
            }).disposed(by: disposeBag)

        input.doLaterButtonDidTap
            .asObservable()
            .map { WalkhubStep.tabsIsRequired }
            .bind(to: steps)
            .disposed(by: disposeBag)

        return Output()
    }
}
