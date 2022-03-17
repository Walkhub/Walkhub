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
        let cellTap: Driver<IndexPath>
    }

    struct Output {
        let schoolList: BehaviorRelay<[SearchSchool]>
    }

    func transform(_ input: Input) -> Output {
        let schoolList = BehaviorRelay<[SearchSchool]>(value: [])

        input.search.asObservable().flatMap {
            self.searchSchoolUseCase.excute(name: $0)
        }.subscribe(onNext: {
            schoolList.accept($0)
        }).disposed(by: disposeBag)

        input.cellTap.asObservable()
            .map { index -> (Int, String) in
                let value = schoolList.value
                return (value[index.row].id, value[index.row].name)
            }.map {
                WalkhubStep.backEidtProfileScene(
                    schoolId: $0,
                    schoolName: $1
                )
            }.bind(to: steps)
            .disposed(by: disposeBag)

        return Output(schoolList: schoolList)
    }
}
