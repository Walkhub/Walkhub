import Foundation

import RxSwift

protocol ChallengeRepository {
    func fetchChallengesList() -> Single<[Challenge]>
    func fetchChallengeDetail(challengeID: Int) -> Single<ChallengeDetail>
    func joinChallenges(challengeID: Int) -> Single<Void>
    func fetchParticipantsChallengesList(challengeID: Int) -> Single<ChallengeParticipantList>
    func fetchJoingChallenges() -> Single<[Challenge]>
}
