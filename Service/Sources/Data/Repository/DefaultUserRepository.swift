import Foundation

import RxSwift

class DefaultUserRepository: UserRepository {

    func changePassword(
        accountID: String,
        phoneNumber: String,
        authCode: String,
        newPassword: String
    ) -> Single<Void> {
        return RemoteUserDataSource.shared.changePassword(
            accountID: accountID,
            phoneNumber: phoneNumber,
            authCode: authCode,
            newPassword: newPassword
        )
    }

    func fetchProfile(userID: Int) -> Observable<UserProfile> {
        return OfflineCacheUtil<UserProfile>()
            .localData { LocalUserDataSource.shared.fetchProfile(userID: userID) }
            .remoteData { RemoteUserDataSource.shared.fetchProfile(userID: userID) }
            .doOnNeedRefresh { LocalUserDataSource.shared.storeProfile(profile: $0) }
            .createObservable()
    }

    func fetchMyProfile() -> Observable<UserProfile> {
        return OfflineCacheUtil<UserProfile>()
            .localData { LocalUserDataSource.shared.fetchMyProfile() }
            .remoteData { RemoteUserDataSource.shared.fetchMyProfile() }
            .doOnNeedRefresh { LocalUserDataSource.shared.storeMyProfile(profile: $0) }
            .createObservable()
    }

    func fetchBadges(userID: Int) -> Observable<[Badge]> {
        return OfflineCacheUtil<[Badge]>()
            .localData { LocalUserDataSource.shared.fetchBadges(userID: userID) }
            .remoteData { RemoteUserDataSource.shared.fetchBadges(userID: userID) }
            .doOnNeedRefresh { LocalUserDataSource.shared.storeBadges(userID: userID, badges: $0) }
            .createObservable()
    }

    func setMainBadge(badgeId: Int) -> Single<Void> {
        return RemoteUserDataSource.shared.setMainBadge(badgeId: badgeId)
    }

    func changeProfile(
        name: String,
        profileImageUrlString: String,
        birthday: String,
        sex: Sex
    ) -> Single<Void> {
        return RemoteUserDataSource.shared.changeProfile(
            name: name,
            profileImageUrlString: profileImageUrlString,
            birthday: birthday,
            sex: sex
        )
    }

    func patchHealth(height: Float, weight: Int) -> Single<Void> {
        return RemoteUserDataSource.shared.patchHealth(height: height, weight: weight)
    }

    func joinClass(groupId: Int) -> Single<Void> {
        return RemoteUserDataSource.shared.joinClass(groupId: groupId)
    }

    func setSchoolInformation(schoolId: String) -> Single<Void> {
        return RemoteUserDataSource.shared.setSchoolInformation(schoolId: schoolId)
    }

}
