import Foundation

import Moya
import RxSwift

final class ChallengesService: BaseService<ChallengesAPI> {
    func fetchChallengesList() -> Single<Response> {
        return request(.fetchChallengesList)
    }
    func fetchDetailChallenges(challengeID: Int) -> Single<Response> {
        return request(.fetchDetailChallenges(challengeID: challengeID))
    }
    func joinChallenges(challengeID: Int) -> Single<Response> {
        return request(.joinChallenges(challengeID: challengeID))
    }
    func fetchParticipantsChallengesList(challengeID: Int) -> Single<Response> {
        return request(.fetchParticipantsChallengesList(challengeID: challengeID))
    }
}
