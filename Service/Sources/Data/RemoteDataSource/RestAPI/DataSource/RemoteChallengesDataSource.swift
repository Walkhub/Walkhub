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

    func fetchChallengeDetail(challengeId: Int) -> Single<ChallengeDetail> {
        return request(.fetchChallengeDetail(challengeId: challengeId))
            .map(ChallengeDetailDTO.self)
            .map { $0.toDomain() }
    }

    func joinChallenges(challengeId: Int) -> Completable {
        return request(.joinChallenges(challengeId: challengeId))
            .asCompletable()
    }

    func fetchParticipantsChallengesList(challengeId: Int) -> Single<ChallengeParticipantList> {
        return request(.fetchParticipantsChallengesList(challengeId: challengeId))
            .map(ChallengeParticipantListDTO.self)
            .map { $0.toDomain() }
    }

    func fetchJoinedChallenges() -> Single<[JoinedChallenge]> {
        return request(.fetchJoinedChallenges)
            .map(JoinedChallengeListDTO.self)
            .map { $0.toDomain() }
    }

    func fetchEndChallengeList() -> Single<[Challenge]> {
        return request(.fetchEndChallengeList)
            .map(ChallengeListDTO.self)
            .map { $0.toDomain() }
    }
}
