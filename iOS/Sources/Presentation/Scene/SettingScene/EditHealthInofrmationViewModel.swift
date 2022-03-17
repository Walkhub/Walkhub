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

        input.getData.asObservable().flatMap {
            self.fetchHealthInformationUseCase.excute()
        }.subscribe(onNext: {
            healthData.accept($0)
        }).disposed(by: disposeBag)

        input.postData.asObservable().flatMap {
            Observable.zip(
                input.height.asObservable(),
                input.weight.asObservable(),
                input.sex.asObservable()
            ) { (height: $0, weight: $1, sex: $2) }
        }.flatMap {
            self.editHealthInformationUseCase.excute(
                height: Float($0.height) ?? 0.0,
                weight: Int($0.weight) ?? 0,
                sex: $0.sex
            )
        }.subscribe(onNext: { _ in
        }).disposed(by: disposeBag)

        return Output(healthData: healthData)
    }
}
