import Foundation

import RxSwift

class DefaultBadgeRepository: BadgeRepository {

    private let remoteBadgesDataSource = RemoteBadgesDataSource.shared
    private let localUserDataSource = LocalUserDataSource.shared

    func fetchBadgeList(userId: Int) -> Observable<[Badge]> {
        return OfflineCacheUtil<[Badge]>()
            .localData { self.localUserDataSource.fetchBadges(userID: userId) }
            .remoteData { self.remoteBadgesDataSource.fetchUserBadgeList(userId: userId) }
            .doOnNeedRefresh { self.localUserDataSource.storeBadges(userID: userId, badges: $0) }
            .createObservable()
    }

    func fetchGetBadges() -> Single<[Badge]> {
        return remoteBadgesDataSource.fetchGetBadges()
    }

    func fetchMyBadgeList() -> Single<[MyBadge]> {
        return remoteBadgesDataSource.fetchMyBadgeList()
    }
}
