import Foundation

import RxSwift

final class LocalChallengeDataSource {

    static let shared = LocalChallengeDataSource()

    private let realm = RealmTask.shared

    private init() { }

    func fetchChallengeList() -> Single<[Challenge]> {
        return realm.fetchObjects(
            for: ChallengeRealmEntity.self,
               filter: QueryFilter.string(query: "isJoined = false")
        ).map { $0.map { $0.toDomain() } }
    }

    func storeChallengeList(challengeList: [Challenge]) {
        let challengeEntityList = challengeList.map { challenge in
            return ChallengeRealmEntity().then {
                $0.setup(challenge: challenge, isJoined: false)
            }
        }
        realm.set(challengeEntityList)
    }

    func fetchJoinedChallengeList() -> Single<[JoinedChallenge]> {
        return realm.fetchObjects(
            for: JoinedChallengeRealmEntity.self
        ).map { $0.map { $0.toDomain() } }
    }

    func storeJoinedChallengeList(challengeList: [JoinedChallenge]) {
        let challengeEntityList = challengeList.map { challenge in
            return JoinedChallengeRealmEntity().then {
                $0.setup(list: challenge)
            }
        }
        realm.set(challengeEntityList)
    }

}
