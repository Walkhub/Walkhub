import Foundation

import RxSwift

protocol BadgeRepository {
    func fetchBadgeList(userId: Int) -> Observable<[Badge]>
    func setMainBadge(badgeId: Int) -> Single<Void>
    func fetchGetBadges() -> Single<[Badge]>
    func fetchMyBadgeList() -> Single<[MyBadge]>
}
