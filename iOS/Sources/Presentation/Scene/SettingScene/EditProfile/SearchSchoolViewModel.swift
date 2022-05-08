import Foundation

import RxSwift
import RxCocoa
import RxFlow
import Service

class SearchSchoolViewModel: ViewModelType, Stepper {
    private let searchSchoolUseCase: SearchSchoolUseCase

    init(searchSchoolUseCase: SearchSchoolUseCase) {
        self.searchSchoolUseCase = searchSchoolUseCase
    }

    private var disposeBag = DisposeBag()
    var steps = PublishRelay<Step>()

    struct Input {
        let search: Driver<String>
        let cellSelected: Driver<IndexPath>
    }

    struct Output {
        let searchSchool: BehaviorRelay<[SearchSchool]>
        let schoolInfo: PublishRelay<SearchSchool>
    }

    func transform(_ input: Input) -> Output {
        let searchSchool = BehaviorRelay<[SearchSchool]>(value: [])
        let schoolInfo = PublishRelay<SearchSchool>()

        input.search.asObservable()
            .debounce(.milliseconds(200),
                      scheduler: MainScheduler.asyncInstance
            ).flatMap {
                self.searchSchoolUseCase.excute(name: $0)
            }.subscribe(onNext: {
                searchSchool.accept($0)
            }).disposed(by: disposeBag)

        input.cellSelected.asObservable()
            .flatMap { index -> Single<Step> in
                let value = searchSchool.value
                schoolInfo.accept(value[index.row])
                return Single.just(WalkhubStep.backToScene)
            }.bind(to: steps)
            .disposed(by: disposeBag)

        return Output(searchSchool: searchSchool, schoolInfo: schoolInfo)
    }
}
