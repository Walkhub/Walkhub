import Foundation

import RxSwift
import RxCocoa
import Service
import RxFlow

class DetailedChallengeViewModel: ViewModelType, Stepper {

    private let fetchChallengeDetailUseCase: FetchChallengeDetailUseCase
    private let joinChallengeUseCase: JoinChallengesUseCase

    init (
        fetchChallengeDetailUseCase: FetchChallengeDetailUseCase,
        joinChallengeUseCase: JoinChallengesUseCase
    ) {
        self.fetchChallengeDetailUseCase = fetchChallengeDetailUseCase
        self.joinChallengeUseCase = joinChallengeUseCase
    }

    private var disposeBag = DisposeBag()

    var steps = PublishRelay<Step>()

    struct Input {
        let challengeId: Driver<Int>
        let joinButtonDidTap: Driver<Void>
    }

    struct Output {
        let detailChallenge: PublishRelay<ChallengeDetail>
    }

    func transform(_ input: Input) -> Output {
        let detailChallenge = PublishRelay<ChallengeDetail>()

        input.challengeId.asObservable().flatMap { id in
            self.fetchChallengeDetailUseCase.excute(challengeId: id)
        }.subscribe(onNext: {
            detailChallenge.accept($0)
        }).disposed(by: disposeBag)

        input.joinButtonDidTap.asObservable()
            .withLatestFrom(input.challengeId)
            .flatMap { id in
                self.joinChallengeUseCase.excute(challengeId: id)
            }.subscribe(onNext: { _ in
            }).disposed(by: disposeBag)

        return Output(detailChallenge: detailChallenge)
    }
}
