import Foundation

import RxSwift

public class FetchParticipantsChallengesListUseCase {

    private let challengeRepository: ChallengeRepository

    init(challengeRepository: ChallengeRepository) {
        self.challengeRepository = challengeRepository
    }

    public func excute(challengeId: Int) -> Single<ChallengeParticipantList> {
        return self.challengeRepository.fetchParticipantsChallengesList(challengeId: challengeId)
    }

}
