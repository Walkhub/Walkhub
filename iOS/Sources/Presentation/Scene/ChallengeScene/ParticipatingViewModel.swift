import Foundation

import RxSwift
import RxCocoa
import Service
import RxFlow

class ParticipatingViewModel: ViewModelType, Stepper {

    private let fetchChallengeDetailUseCase: FetchChallengeDetailUseCase

    private var disposeBag = DisposeBag()

    var steps = PublishRelay<Step>()

    init (
        fetchChallengeDetailUseCase: FetchChallengeDetailUseCase
    ) {
        self.fetchChallengeDetailUseCase = fetchChallengeDetailUseCase
    }

    struct Input {
        let getData: Driver<Int>
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

        return Output(detailChallenge: detailChallenge)
    }
}
