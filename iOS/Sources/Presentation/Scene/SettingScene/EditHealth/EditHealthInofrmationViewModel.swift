import Foundation

import RxSwift
import RxCocoa
import RxFlow
import Service

class EditHealthInformationViewModel: ViewModelType, Stepper {

    private let fetchHealthInformationUseCase: FetchHealthInformationUseCase
    private let editHealthInformationUseCase: EditHealthInformationUseCase

    init(
        fetchHealthInformationUseCase: FetchHealthInformationUseCase,
        editHealthInformationUseCase: EditHealthInformationUseCase
    ) {
        self.fetchHealthInformationUseCase = fetchHealthInformationUseCase
        self.editHealthInformationUseCase = editHealthInformationUseCase
    }

    private var disposeBag = DisposeBag()
    var steps = PublishRelay<Step>()

    struct Input {
        let getData: Driver<Void>
        let height: Driver<String>
        let weight: Driver<String>
        let sex: Driver<Sex>
        let postData: Driver<Void>
    }

    struct Output {
        let healthData: PublishRelay<UserHealth>
    }

    func transform(_ input: Input) -> Output {
        let healthData = PublishRelay<UserHealth>()
        let info = Driver.combineLatest(input.height, input.weight, input.sex)

        input.getData.asObservable().flatMap {
            self.fetchHealthInformationUseCase.excute()
        }.subscribe(onNext: {
            healthData.accept($0)
        }).disposed(by: disposeBag)

        input.postData.asObservable()
            .withLatestFrom(info)
            .flatMap {
                self.editHealthInformationUseCase.excute(
                    height: Double($0),
                    weight: Int(Double($1) ?? 0),
                    sex: $2
                ).andThen(Single.just(WalkhubStep.backToScene))
            }.bind(to: steps)
            .disposed(by: disposeBag)

        return Output(healthData: healthData)
    }
}
