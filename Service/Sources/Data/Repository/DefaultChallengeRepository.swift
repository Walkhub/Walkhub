import Foundation

import RxSwift

class DefaultChallengeRepository: ChallengeRepository {

    private let remoteChallengesDataSource = RemoteChallengesDataSource.shared
    private let localChallengeDataSource = LocalChallengeDataSource.shared

    func fetchChallengesList() -> Observable<[Challenge]> {
        OfflineCacheUtil<[Challenge]>()
            .localData { self.localChallengeDataSource.fetchChallengeList() }
            .remoteData { self.remoteChallengesDataSource.fetchChallengesList() }
            .doOnNeedRefresh { self.localChallengeDataSource.storeChallengeList(challengeList: $0) }
            .createObservable()
    }

    func fetchChallengeDetail(challengeId: Int) -> Single<ChallengeDetail> {
        remoteChallengesDataSource.fetchChallengeDetail(challengeId: challengeId)
    }

    func joinChallenges(challengeId: Int) -> Completable {
        remoteChallengesDataSource.joinChallenges(challengeId: challengeId)
    }

    func fetchParticipantsChallengesList(challengeId: Int) -> Single<ChallengeParticipantList> {
        remoteChallengesDataSource.fetchParticipantsChallengesList(challengeId: challengeId)
    }

    func fetchJoinedChallenges() -> Observable<[JoinedChallenge]> {
        OfflineCacheUtil<[JoinedChallenge]>()
            .localData { self.localChallengeDataSource.fetchJoinedChallengeList() }
            .remoteData { self.remoteChallengesDataSource.fetchJoinedChallenges() }
            .doOnNeedRefresh { self.localChallengeDataSource.storeJoinedChallengeList(challengeList: $0) }
            .createObservable()
    }

    func fetchEndChallengList() -> Single<[Challenge]> {
        remoteChallengesDataSource.fetchEndChallengeList()
    }
}
