import Foundation

import RxSwift
import RxCocoa
import Service

class RankViewModel: ViewModelType {

    private let fetchUserRankUseCase: FetchUserSchoolRankUseCase

    init(
        fetchUserRankUseCase: FetchUserSchoolRankUseCase
    ) {
        self.fetchUserRankUseCase = fetchUserRankUseCase
    }

    private var disposeBag = DisposeBag()

    struct Input {
        let switchOn: Driver<Scope>
        let dayType: Driver<DateType>
    }

    struct Output {
        let myRank: PublishRelay<(User, Int?)>
        let userList: PublishRelay<[User]>
    }

    func transform(_ input: Input) -> Output {
        let myRank = PublishRelay<(User, Int?)>()
        let userList = PublishRelay<[User]>()
        let info = Driver.combineLatest(input.switchOn, input.dayType)

        input.switchOn.asObservable().withLatestFrom(info).flatMap {
            self.fetchUserRankUseCase.excute(scope: $0, dateType: $1)
        }.subscribe(onNext: { data, num in
            myRank.accept((data.myRank, num))
            userList.accept(data.rankList)
        }).disposed(by: disposeBag)

        input.dayType.asObservable().withLatestFrom(info).flatMap {
            self.fetchUserRankUseCase.excute(scope: $0, dateType: $1)
        }.subscribe(onNext: { data, num in
            myRank.accept((data.myRank, num))
            userList.accept(data.rankList)
        }).disposed(by: disposeBag)

        return Output(myRank: myRank, userList: userList)
    }
}
