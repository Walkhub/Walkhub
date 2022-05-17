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
        let moveDetailedChallenge: Driver<Void>
    }

    struct Output {
        let joinedChallengeList: PublishRelay<[JoinedChallenge]>
        let challengList: PublishRelay<[Challenge]>
    }

    func transform(_ input: Input) -> Output {
        let joinedChallengeList = PublishRelay<[JoinedChallenge]>()
        let challengeList = PublishRelay<[Challenge]>()

        input.getData.asObservable().flatMap {
            self.fetchJoinedChallengesUseCase.excute()
        }.subscribe(onNext: {
            joinedChallengeList.accept($0)
        }).disposed(by: disposeBag)

        input.getData.asObservable().flatMap {
            self.fetchChallengesListUseCase.excute()
        }.subscribe(onNext: {
            print($0)
            challengeList.accept($0)
        }).disposed(by: disposeBag)

        input.moveDetailedChallenge.asObservable()
            .map { WalkhubStep.challengeIsRequired }
            .bind(to: steps)
            .disposed(by: disposeBag)

        return Output(
            joinedChallengeList: joinedChallengeList,
            challengList: challengeList
        )
    }
}
