import Foundation

import RxSwift

public class FetchChallengesListUseCase {

    private let challengeRepository: ChallengeRepository

    init(challengeRepository: ChallengeRepository) {
        self.challengeRepository = challengeRepository
    }

    public func excute() -> Observable<[Challenge]> {
        return self.challengeRepository.fetchChallengesList()
    }

}
