import Foundation

import RxSwift

protocol BadgeRepository {
    func fetchBadgeList(userId: Int) -> Observable<[Badge]>
    func fetchGetBadges() -> Single<[Badge]>
    func fetchMyBadgeList() -> Single<[MyBadge]>
}
