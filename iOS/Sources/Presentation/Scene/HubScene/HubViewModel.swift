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
        let dayData: Driver<Void>
        let weekData: Driver<Void>
        let monthData: Driver<Void>
    }

    struct Output {
        let mySchoolRank: PublishRelay<MySchool>
        let schoolRank: PublishRelay<[School]>
    }

    func transform(_ input: Input) -> Output {
        let mySchoolRank = PublishRelay<MySchool>()
        let schoolRank = PublishRelay<[School]>()

        input.dayData.asObservable().flatMap {
            self.fetchSchoolUseCase.excute(dateType: .day)
        }.subscribe(onNext: {
            mySchoolRank.accept($0.mySchoolRank)
            schoolRank.accept($0.schoolList)
        }).disposed(by: disposeBag)

        input.weekData.asObservable().flatMap {
            self.fetchSchoolUseCase.excute(dateType: .week)
        }.subscribe(onNext: {
            mySchoolRank.accept($0.mySchoolRank)
            schoolRank.accept($0.schoolList)
        }).disposed(by: disposeBag)

        input.monthData.asObservable().flatMap {
            self.fetchSchoolUseCase.excute(dateType: .month)
        }.subscribe(onNext: {
            mySchoolRank.accept($0.mySchoolRank)
            schoolRank.accept($0.schoolList)
        }).disposed(by: disposeBag)

        return Output(mySchoolRank: mySchoolRank, schoolRank: schoolRank)
    }
}
