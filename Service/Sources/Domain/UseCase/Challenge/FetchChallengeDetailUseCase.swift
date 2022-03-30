import Foundation

import RxSwift

public class FetchChallengeDetailUseCase {

    private let challengeRepository: ChallengeRepository

    init(challengeRepository: ChallengeRepository) {
        self.challengeRepository = challengeRepository
    }

    public func excute(challengeId: Int) -> Single<ChallengeDetail> {
        challengeRepository.fetchChallengeDetail(challengeId: challengeId)
    }

}
