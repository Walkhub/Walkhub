import Foundation

import Moya
import RxSwift

final class RemoteChallengesDataSource: RestApiRemoteDataSource<ChallengesAPI> {

    static let shared = RemoteChallengesDataSource()

    private override init() { }

    func fetchChallengesList() -> Single<[Challenge]> {
        return request(.fetchChallengesList)
            .map(ChallengeListDTO.self)
            .map { $0.toDomain() }
    }

    func fetchChallengeDetail(challengeID: Int) -> Single<ChallengeDetail> {
        return request(.fetchChallengeDetail(challengeID: challengeID))
            .map(ChallengeDetailDTO.self)
            .map { $0.toDomain() }
    }

    func joinChallenges(challengeID: Int) -> Single<Void> {
        return request(.joinChallenges(challengeID: challengeID))
            .map { _ in () }
    }

    func fetchParticipantsChallengesList(challengeID: Int) -> Single<ChallengeParticipantList> {
        return request(.fetchParticipantsChallengesList(challengeID: challengeID))
            .map(ChallengeParticipantListDTO.self)
            .map { $0.toDomain() }
    }

    func fetchJoingChallenges() -> Single<[Challenge]> {
        return request(.fetchJoinedChallenges)
            .map(ChallengeListDTO.self)
            .map { $0.toDomain() }
    }
}
