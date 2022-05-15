import Foundation

import RxCocoa
import RxFlow
import RxSwift
import Service

class HubViewModel: ViewModelType, Stepper {

    private let fetchSchoolUseCase: FetchSchoolRankUseCase
    private let searchSchoolRankUseCase: SearchSchoolRankUseCase
    private let searchSchoolUseCase: SearchSchoolUseCase

    init(
        fetchSchoolUseCase: FetchSchoolRankUseCase,
        searchSchoolRankUseCase: SearchSchoolRankUseCase,
        searchSchoolUseCase: SearchSchoolUseCase
    ) {
        self.fetchSchoolUseCase = fetchSchoolUseCase
        self.searchSchoolRankUseCase = searchSchoolRankUseCase
        self.searchSchoolUseCase = searchSchoolUseCase
    }

    private var disposeBag = DisposeBag()
    var steps = PublishRelay<Step>()

    struct Input {
        let dateType: Driver<DateType>
        let name: Driver<String>
    }

    struct Output {
        let mySchoolRank: PublishRelay<MySchool>
        let schoolRank: PublishRelay<[School]>
        let searchSchoolList: PublishRelay<[SearchSchool]>
    }

    func transform(_ input: Input) -> Output {
        let mySchoolRank = PublishRelay<MySchool>()
        let schoolRank = PublishRelay<[School]>()
        let searchSchoolList = PublishRelay<[SearchSchool]>()
        let info = Driver.combineLatest(input.name, input.dateType)

        input.dateType.asObservable()
            .flatMap { _ in
                self.fetchSchoolUseCase.excute()
            }.subscribe(onNext: {
                print($0)
                mySchoolRank.accept($0)
            }).disposed(by: disposeBag)

        input.dateType.asObservable()
            .flatMap {
                self.searchSchoolRankUseCase.excute(name: nil, dateType: $0)
            }.subscribe(onNext: {
                print($0)
                schoolRank.accept($0)
            }).disposed(by: disposeBag)

        input.name.asObservable()
            .flatMap {
                self.searchSchoolUseCase.excute(name: $0)
            }.subscribe(onNext: {
                searchSchoolList.accept($0)
            }).disposed(by: disposeBag)

        return Output(
            mySchoolRank: mySchoolRank,
            schoolRank: schoolRank,
            searchSchoolList: searchSchoolList
        )
    }
}
