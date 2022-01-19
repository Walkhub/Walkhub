import Foundation

import Moya
import RxSwift

final class ChallengesService: BaseService<ChallengesAPI> {
    func viewChallengesList() -> Single<Response> {
        return request(.viewChallengesList)
    }
    func viewDetailChallenges(challengeID: Int) -> Single<Response> {
        return request(.viewDetailChallenges(challengeID: challengeID))
    }
    func participationChallenges(challengeID: Int) -> Single<Response> {
        return request(.participationChallenges(challengeID: challengeID))
    }
    func viewParticipantsChallengesList(challengeID: Int) -> Single<Response> {
        return request(.viewParticipantsChallengesList(challengeID: challengeID))
    }
}
