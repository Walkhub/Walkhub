import Foundation

import RxSwift
import RxCocoa
import Service
import RxFlow

class AnotherSchoolRankViewModel: ViewModelType {
    private let fetchAnotherSchoolUserRankUseCase: FetchAnotherSchoolUserRankUseCase

    init(fetchAnotherSchoolUserRankUseCase: FetchAnotherSchoolUserRankUseCase) {
        self.fetchAnotherSchoolUserRankUseCase = fetchAnotherSchoolUserRankUseCase
    }

    private var disposeBag = DisposeBag()

    struct Input {
        let schoold: Int
        let dateType: Driver<DateType>
    }
    struct Output {
        let userRankList: PublishRelay<[RankedUser]>
    }

    func transform(_ input: Input) -> Output {
        let userRankList = PublishRelay<[RankedUser]>()

        input.dateType
            .asObservable()
            .flatMap { dateType -> Observable<[RankedUser]> in
                return self.fetchAnotherSchoolUserRankUseCase.excute(
                    schoolId: input.schoold,
                    dateType: dateType
                )
            }.subscribe(onNext: {
                userRankList.accept($0)
            }).disposed(by: disposeBag)

        return Output(userRankList: userRankList)
    }
}
