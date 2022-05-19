import Foundation

import RxSwift
import RxCocoa
import RxFlow
import Service

class RankViewModel: ViewModelType, Stepper {

    private let fetchMySchoolUserRankUseCase: FetchMySchoolUserRankUseCase
    private let fetchAnotherSchoolUserRankUseCase: FetchAnotherSchoolUserRankUseCase

    init(
        fetchMySchoolUserRankUseCase: FetchMySchoolUserRankUseCase,
        fetchAnotherSchoolUserRankUseCase: FetchAnotherSchoolUserRankUseCase
    ) {
        self.fetchMySchoolUserRankUseCase = fetchMySchoolUserRankUseCase
        self.fetchAnotherSchoolUserRankUseCase = fetchAnotherSchoolUserRankUseCase
    }

    var steps = PublishRelay<Step>()
    private var disposeBag = DisposeBag()

    struct Input {
        let getData: Driver<Void>
        let schoolId: Int?
        let dateType: Driver<DateType>
        let groupScope: Driver<GroupScope>
    }
    struct Output {
        let myRank: PublishRelay<(RankedUser, Int?)>
        let userRankList: PublishRelay<[RankedUser]>
    }

    func transform(_ input: Input) -> Output {
        let myRank = PublishRelay<(RankedUser, Int?)>()
        let userRankList = PublishRelay<[RankedUser]>()

        return Output(
            myRank: myRank,
            userRankList: userRankList
        )
    }
}
