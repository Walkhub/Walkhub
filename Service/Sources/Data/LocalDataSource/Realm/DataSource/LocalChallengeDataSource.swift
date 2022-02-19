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

    func fetchJoinedChallengeList() -> Single<[Challenge]> {
        return realm.fetchObjects(
            for: ChallengeRealmEntity.self,
               filter: QueryFilter.string(query: "isJoined = true")
        ).map { $0.map { $0.toDomain() } }
    }

    func storeJoinedChallengeList(challengeList: [Challenge]) {
        let challengeEntityList = challengeList.map { challenge in
            return ChallengeRealmEntity().then {
                $0.setup(challenge: challenge, isJoined: true)
            }
        }
        realm.set(challengeEntityList)
    }

}
