import Foundation

import RxSwift
import RxCocoa
import RxFlow
import Service

class RankViewModel: ViewModelType, Stepper {

    private let fetchMySchoolUserRankUseCase: FetchMySchoolUserRankUseCase

    init(
        fetchMySchoolUserRankUseCase: FetchMySchoolUserRankUseCase
    ) {
        self.fetchMySchoolUserRankUseCase = fetchMySchoolUserRankUseCase
    }

    var steps = PublishRelay<Step>()
    private var disposeBag = DisposeBag()

    struct Input {
        let schoolId: Int
        let dateType: Driver<DateType>
        let groupScope: Driver<GroupScope>
    }
    struct Output {
        let myRank: PublishRelay<(RankedUser, Int?)>
        let userRankList: PublishRelay<[RankedUser]>
        let isJoined: PublishRelay<Bool>
    }

    func transform(_ input: Input) -> Output {
        let myRank = PublishRelay<(RankedUser, Int?)>()
        let userRankList = PublishRelay<[RankedUser]>()
        let isJoined = PublishRelay<Bool>()
        let mySchoolInfo = Driver.combineLatest(input.groupScope, input.dateType)

        input.groupScope
            .asObservable()
            .withLatestFrom(mySchoolInfo)
            .flatMap {
                self.fetchMySchoolUserRankUseCase.excute(scope: $0, dateType: $1)
            }.subscribe(onNext: {
                myRank.accept(($0.0.myRank, $0.1))
                userRankList.accept($0.0.rankList)
                isJoined.accept($0.0.isJoinedClass)
            }).disposed(by: disposeBag)

        input.dateType
            .asObservable()
            .withLatestFrom(mySchoolInfo)
            .flatMap {
                self.fetchMySchoolUserRankUseCase.excute(scope: $0, dateType: $1)
            }.subscribe(onNext: {
                myRank.accept(($0.0.myRank, $0.1))
                userRankList.accept($0.0.rankList)
                isJoined.accept($0.0.isJoinedClass)
            }).disposed(by: disposeBag)

        return Output(
            myRank: myRank,
            userRankList: userRankList,
            isJoined: isJoined
        )
    }
}
