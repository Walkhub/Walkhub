import Foundation

import RxSwift

public class FetchJoinedChallengesUseCase {

    private let challengeRepository: ChallengeRepository

    init(challengeRepository: ChallengeRepository) {
        self.challengeRepository = challengeRepository
    }

    public func excute() -> Observable<[JoinedChallenge]> {
        return self.challengeRepository.fetchJoinedChallenges()
    }

}
