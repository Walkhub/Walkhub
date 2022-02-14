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
        let schoolRank: PublishRelay<SchoolRank>
    }

    func transform(_ input: Input) -> Output {
        let schoolRank = PublishRelay<SchoolRank>()

        input.dayData.asObservable().flatMap {
            self.fetchSchoolUseCase.excute(dateType: .day)
        }.subscribe(onNext: {
            schoolRank.accept($0)
        }).disposed(by: disposeBag)

        input.weekData.asObservable().flatMap {
            self.fetchSchoolUseCase.excute(dateType: .week)
        }.subscribe(onNext: {
            schoolRank.accept($0)
        }).disposed(by: disposeBag)

        input.monthData.asObservable().flatMap {
            self.fetchSchoolUseCase.excute(dateType: .month)
        }.subscribe(onNext: {
            schoolRank.accept($0)
        }).disposed(by: disposeBag)

        return Output(schoolRank: schoolRank)
    }
}
