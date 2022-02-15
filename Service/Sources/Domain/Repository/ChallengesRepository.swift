import Foundation

import RxSwift

protocol ChallengesRepository {
    func fetchChallengesList() -> Single<[Challenge]>
    func fetchDetailChallenges(challengeID: Int) -> Single<ChallengeDetail>
    func joinChallenges(challengeID: Int) -> Single<Void>
    func fetchParticipantsChallengesList(challengeID: Int) -> Single<ChallengeParticipantList>
    func fetchJoingChallenges() -> Single<[Challenge]>
}
