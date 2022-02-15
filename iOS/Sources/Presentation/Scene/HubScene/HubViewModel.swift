import Foundation

import RxSwift
import RxCocoa
import Service

class HubViewModel: ViewModelType {

    private let fetchSchoolUseCase: FetchSchoolRankUseCase

    init(fetchSchoolUseCase: FetchSchoolRankUseCase) {
        self.fetchSchoolUseCase = fetchSchoolUseCase
    }

    private var disposeBag = DisposeBag()

    struct Input {
        let dateType: Driver<DateType>
    }

    struct Output {
        let mySchoolRank: PublishRelay<MySchool>
        let schoolRank: PublishRelay<[School]>
    }

    func transform(_ input: Input) -> Output {
        let mySchoolRank = PublishRelay<MySchool>()
        let schoolRank = PublishRelay<[School]>()

        input.dateType.asObservable().withLatestFrom(input.dateType).flatMap {
            self.fetchSchoolUseCase.excute(dateType: $0)
        }.subscribe(onNext: {
            mySchoolRank.accept($0.mySchoolRank)
            schoolRank.accept($0.schoolList)
        }).disposed(by: disposeBag)

        return Output(mySchoolRank: mySchoolRank, schoolRank: schoolRank)
    }
}
