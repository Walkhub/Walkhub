import Foundation

import RxSwift

public class FetchEndChallengListUseCase {

    private let challengeRepository: ChallengeRepository

    init(challengeRepository: ChallengeRepository) {
        self.challengeRepository = challengeRepository
    }

    public func excute() -> Single<[Challenge]> {
        challengeRepository.fetchEndChallengList()
    }

}
