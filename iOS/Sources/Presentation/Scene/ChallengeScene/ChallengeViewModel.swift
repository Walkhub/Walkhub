import Foundation

import RxSwift
import RxCocoa
import Service
import RxFlow

class ChallengeViewModel: ViewModelType, Stepper {

    private let fetchChallengesListUseCase: FetchChallengesListUseCase
    private let fetchJoinedChallengesUseCase: FetchJoinedChallengesUseCase

    init(
        fetchChallengesListUseCase: FetchChallengesListUseCase,
        fetchJoinedChallengesUseCase: FetchJoinedChallengesUseCase
    ) {
        self.fetchChallengesListUseCase = fetchChallengesListUseCase
        self.fetchJoinedChallengesUseCase = fetchJoinedChallengesUseCase
    }

    private var disposeBag = DisposeBag()

    var steps = PublishRelay<Step>()

    struct Input {
        let getData: Driver<Void>
        let cellDidSelect: Driver<IndexPath>
    }

    struct Output {
        let joinedChallengeList: PublishRelay<[JoinedChallenge]>
        let challengList: BehaviorRelay<[Challenge]>
    }

    func transform(_ input: Input) -> Output {
        let joinedChallengeList = PublishRelay<[JoinedChallenge]>()
        let challengeList = BehaviorRelay<[Challenge]>(value: [])

        input.getData.asObservable().flatMap {
            self.fetchJoinedChallengesUseCase.excute()
        }.subscribe(onNext: {
            print($0)
            joinedChallengeList.accept($0)
        }).disposed(by: disposeBag)

        input.getData.asObservable().flatMap {
            self.fetchChallengesListUseCase.excute()
        }.subscribe(onNext: {
            print($0)
            challengeList.accept($0)
        }).disposed(by: disposeBag)

        input.cellDidSelect
            .asObservable()
            .flatMap { index -> Single<Step> in
                let value = challengeList.value
                return Single.just(WalkhubStep.detailedChallengeIsRequired(id: value[index.row].id))
            }.bind(to: steps)
            .disposed(by: disposeBag)
        return Output(
            joinedChallengeList: joinedChallengeList,
            challengList: challengeList
        )
    }
}
