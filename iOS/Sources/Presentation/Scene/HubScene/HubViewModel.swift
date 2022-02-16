import Foundation

import RxSwift
import RxCocoa
import Service

class HubViewModel: ViewModelType {

    private let fetchSchoolUseCase: FetchSchoolRankUseCase
    private let searchSchoolRankUseCase: SearchSchoolRankUseCase

    init(
        fetchSchoolUseCase: FetchSchoolRankUseCase,
         searchSchoolRankUseCase: SearchSchoolRankUseCase
    ) {
        self.fetchSchoolUseCase = fetchSchoolUseCase
        self.searchSchoolRankUseCase = searchSchoolRankUseCase
    }

    private var disposeBag = DisposeBag()

    struct Input {
        let dateType: Driver<DateType>
        let name: Driver<String>
    }

    struct Output {
        let mySchoolRank: PublishRelay<MySchool>
        let schoolRank: PublishRelay<[School]>
        let searchSchoolRankList: PublishRelay<[SearchSchoolRank]>
    }

    func transform(_ input: Input) -> Output {
        let mySchoolRank = PublishRelay<MySchool>()
        let schoolRank = PublishRelay<[School]>()
        let searchSchoolRankList = PublishRelay<[SearchSchoolRank]>()
        let info = Driver.combineLatest(input.name, input.dateType)

        input.dateType.asObservable().withLatestFrom(input.dateType).flatMap {
            self.fetchSchoolUseCase.excute(dateType: $0)
        }.subscribe(onNext: {
            mySchoolRank.accept($0.mySchoolRank)
            schoolRank.accept($0.schoolList)
        }).disposed(by: disposeBag)

        input.name.asObservable().withLatestFrom(info).flatMap {
            self.searchSchoolRankUseCase.excute(name: $0, dateType: $1)
        }.subscribe(onNext: {
            searchSchoolRankList.accept($0)
        }).disposed(by: disposeBag)

        return Output(
            mySchoolRank: mySchoolRank,
            schoolRank: schoolRank,
            searchSchoolRankList: searchSchoolRankList
        )
    }
}
