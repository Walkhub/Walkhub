import Foundation

import RxSwift

class DefaultUserRepository: UserRepository {

    private let remoteUserDataSource = RemoteUserDataSource.shared
    private let localUserDataSource = LocalUserDataSource.shared

    func changePassword(
        accountID: String,
        phoneNumber: String,
        authCode: String,
        newPassword: String
    ) -> Single<Void> {
        return remoteUserDataSource.changePassword(
            accountID: accountID,
            phoneNumber: phoneNumber,
            authCode: authCode,
            newPassword: newPassword
        )
    }

    func fetchProfile(userID: Int) -> Observable<UserProfile> {
        return OfflineCacheUtil<UserProfile>()
            .localData { self.localUserDataSource.fetchProfile(userID: userID) }
            .remoteData { self.remoteUserDataSource.fetchProfile(userID: userID) }
            .doOnNeedRefresh { self.localUserDataSource.storeProfile(profile: $0) }
            .createObservable()
    }

    func fetchMyProfile() -> Observable<UserProfile> {
        return OfflineCacheUtil<UserProfile>()
            .localData { self.localUserDataSource.fetchMyProfile() }
            .remoteData { self.remoteUserDataSource.fetchMyProfile() }
            .doOnNeedRefresh { self.localUserDataSource.storeMyProfile(profile: $0) }
            .createObservable()
    }

    func fetchBadges(userID: Int) -> Observable<[Badge]> {
        return OfflineCacheUtil<[Badge]>()
            .localData { self.localUserDataSource.fetchBadges(userID: userID) }
            .remoteData { self.remoteUserDataSource.fetchBadges(userID: userID) }
            .doOnNeedRefresh { self.localUserDataSource.storeBadges(userID: userID, badges: $0) }
            .createObservable()
    }

    func setMainBadge(badgeID: Int) -> Single<Void> {
        return remoteUserDataSource.setMainBadge(badgeID: badgeID)
    }

    func changeProfile(
        name: String,
        profileImageUrlString: String,
        birthday: String,
        sex: Sex
    ) -> Single<Void> {
        return remoteUserDataSource.changeProfile(
            name: name,
            profileImageUrlString: profileImageUrlString,
            birthday: birthday,
            sex: sex
        )
    }

    func patchHealth(height: Float, weight: Int) -> Single<Void> {
        return remoteUserDataSource.patchHealth(height: height, weight: weight)
    }

    func joinClass(groupId: Int) -> Single<Void> {
        return remoteUserDataSource.joinClass(groupId: groupId)
    }

    func setSchoolInformation(schoolId: String) -> Single<Void> {
        return remoteUserDataSource.setSchoolInformation(schoolId: schoolId)
    }

}
