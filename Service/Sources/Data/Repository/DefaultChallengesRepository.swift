import Foundation

import RxSwift

class DefaultChallengesRepository: ChallengesRepository {
    func fetchChallengesList() -> Single<[Challenge]> {
        return RemoteChallengesDataSource.shared.fetchChallengesList()
    }

    func fetchDetailChallenges(challengeID: Int) -> Single<ChallengeDetail> {
        return RemoteChallengesDataSource.shared.fetchDetailChallenges(challengeID: challengeID)
    }

    func joinChallenges(challengeID: Int) -> Single<Void> {
        return RemoteChallengesDataSource.shared.joinChallenges(challengeID: challengeID)
            .map { _ in () }
    }

    func fetchParticipantsChallengesList(challengeID: Int) -> Single<ChallengeParticipantList> {
        return RemoteChallengesDataSource.shared.fetchParticipantsChallengesList(challengeID: challengeID)
    }

    func fetchJoingChallenges() -> Single<[Challenge]> {
        return RemoteChallengesDataSource.shared.fetchJoingChallenges()
    }
}
