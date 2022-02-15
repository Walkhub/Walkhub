import Foundation

import RxSwift

final class LocalUserDataSource {

    static let shared = LocalUserDataSource()

    private let realmTask = RealmTask.shared

    private init() { }

    func fetchProfile(userID: Int) -> Single<UserProfile> {
        return realmTask.fetchObjects(
            for: UserProfileRealmEntity.self,
               filter: QueryFilter.string(query: "userID = '\(userID)'")
        ).map { $0.first!.toDomain() }
    }

    func storeProfile(profile: UserProfile) {
        let profileEntity = UserProfileRealmEntity()
        profileEntity.setup(profile: profile)
        realmTask.set(profileEntity)
    }

    func fetchMyProfile() -> Single<UserProfile> {
        return realmTask.fetchObjects(
            for: UserProfileRealmEntity.self,
               filter: QueryFilter.string(query: "isMyProfile = true")
        ).map { $0.first!.toDomain() }
    }

    func storeMyProfile(profile: UserProfile) {
        let profileEntity = UserProfileRealmEntity()
        profileEntity.setup(profile: profile, isMyProfile: true)
        realmTask.set(profileEntity)
    }

    func fetchBadges(userID: Int) -> Single<[Badge]> {
        return realmTask.fetchObjects(
            for: BadgeRealmEntity.self,
               filter: QueryFilter.string(query: "ownerID = '\(userID)'")
        ).map { $0.map { $0.toDomain() } }
    }

    func storeBadges(userID: Int, badges: [Badge]) {
        let badgeEntityList = badges.map { badge in
            return BadgeRealmEntity().then {
                $0.setup(ownerID: userID, badge: badge)
            }
        }
        realmTask.set(badgeEntityList)
    }

}
