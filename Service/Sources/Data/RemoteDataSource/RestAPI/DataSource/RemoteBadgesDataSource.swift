import Foundation

import Moya
import RxSwift

final class RemoteBadgesDataSource: RestApiRemoteDataSource<BadgeAPI> {

    static let shared = RemoteBadgesDataSource()

    func fetchUserBadgeList(userId: Int) -> Single<[Badge]> {
        return request(.fetchUserBadgeList(userId: userId))
            .map(BadgeListDTO.self)
            .map { $0.toDomain() }
    }

    func setMainBadge(badgeId: Int) -> Single<Void> {
        return request(.setMainBadge(badgeId: badgeId))
            .map { _ in () }
    }

    func fetchGetBadges() -> Single<[Badge]> {
        return request(.fetchGetBadges)
            .map(BadgeListDTO.self)
            .map { $0.toDomain() }
    }

    func fetchMyBadgeList() -> Single<[MyBadge]> {
        return request(.fetchMyBadgeList)
            .map(MyBadgeListDTO.self)
            .map { $0.toDomain() }
    }
}
