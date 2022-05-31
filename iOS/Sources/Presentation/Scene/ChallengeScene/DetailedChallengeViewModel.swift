import Foundation

import RxSwift
import RxCocoa
import Service
import RxFlow

class DetailedChallengeViewModel: ViewModelType, Stepper {

    private let fetchChallengeDetailUseCase: FetchChallengeDetailUseCase
    private let joinChallengeUseCase: JoinChallengesUseCase

    private var disposeBag = DisposeBag()

    var steps = PublishRelay<Step>()

    init (
        fetchChallengeDetailUseCase: FetchChallengeDetailUseCase,
        joinChallengeUseCase: JoinChallengesUseCase
    ) {
        self.fetchChallengeDetailUseCase = fetchChallengeDetailUseCase
        self.joinChallengeUseCase = joinChallengeUseCase
    }

    struct Input {
        let getData: Driver<Int>
        let joinButtonDidTap: Driver<Void>
    }

    struct Output {
        let detailChallenge: PublishRelay<ChallengeDetail>
    }

    func transform(_ input: Input) -> Output {
        let detailChallenge = PublishRelay<ChallengeDetail>()

        input.getData
            .asObservable()
            .flatMap {
                self.fetchChallengeDetailUseCase.excute(challengeId: $0)
            }.subscribe(onNext: {
                detailChallenge.accept($0)
            }).disposed(by: disposeBag)

        input.joinButtonDidTap.asObservable()
            .withLatestFrom(input.getData)
            .flatMap {
                self.joinChallengeUseCase.excute(challengeId: $0)
            }.subscribe(onNext: { _ in
            }).disposed(by: disposeBag)

        return Output(detailChallenge: detailChallenge)
    }
}
