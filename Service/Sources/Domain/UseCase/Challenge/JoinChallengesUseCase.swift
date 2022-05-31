import Foundation

import RxSwift

public class JoinChallengesUseCase {

    private let challengeRepository: ChallengeRepository

    init(challengeRepository: ChallengeRepository) {
        self.challengeRepository = challengeRepository
    }

    public func excute(challengeId: Int) -> Completable {
        challengeRepository.joinChallenges(challengeId: challengeId)
    }

}
