import Foundation

import RxSwift

class DefaultBadgeRepository: BadgeRepository {
    func fetchBadgeList(userId: Int) -> Observable<[Badge]> {
        return OfflineCacheUtil<[Badge]>()
            .localData { LocalUserDataSource.shared.fetchBadges(userID: userId) }
            .remoteData { RemoteBadgesDataSource.shared.fetchUserBadgeList(userId: userId) }
            .doOnNeedRefresh { LocalUserDataSource.shared.storeBadges(userID: userId, badges: $0) }
            .createObservable()
    }

    func fetchGetBadges() -> Single<[Badge]> {
        return RemoteBadgesDataSource.shared.fetchGetBadges()
    }

    func fetchMyBadgeList() -> Single<[MyBadge]> {
        return RemoteBadgesDataSource.shared.fetchMyBadgeList()
    }
}
