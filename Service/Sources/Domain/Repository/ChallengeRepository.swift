import Foundation

import RxSwift

protocol ChallengeRepository {
    func fetchChallengesList() -> Single<[Challenge]>
    func fetchChallengeDetail(challengeId: Int) -> Single<ChallengeDetail>
    func joinChallenges(challengeId: Int) -> Single<Void>
    func fetchParticipantsChallengesList(challengeId: Int) -> Single<ChallengeParticipantList>
    func fetchJoingChallenges() -> Single<[Challenge]>
}
