import Foundation

import RxSwift

protocol ChallengeRepository {
    func fetchChallengesList() -> Observable<[Challenge]>
    func fetchChallengeDetail(challengeId: Int) -> Single<ChallengeDetail>
    func joinChallenges(challengeId: Int) -> Completable
    func fetchParticipantsChallengesList(challengeId: Int) -> Single<ChallengeParticipantList>
    func fetchJoinedChallenges() -> Observable<[Challenge]>
    func fetchEndChallengList() -> Single<[Challenge]>
}
