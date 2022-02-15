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
    ) -> Completable {
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

    func setMainBadge(badgeId: Int) -> Completable {
        return remoteUserDataSource.setMainBadge(badgeId: badgeId)
    }

    func changeProfile(
        name: String,
        profileImageUrl: URL,
        sex: Sex
    ) -> Completable {
        return remoteUserDataSource.changeProfile(
            name: name,
            profileImageUrl: profileImageUrl,
            sex: sex
        )
    }

    func patchHealthInformation(height: Float, weight: Int) -> Completable {
        return remoteUserDataSource.patchHealthInformation(height: height, weight: weight)
    }

    func joinClass(groupId: Int) -> Completable {
        return remoteUserDataSource.joinClass(groupId: groupId)
    }

    func setSchoolInformation(schoolId: String) -> Completable {
        return remoteUserDataSource.setSchoolInformation(schoolId: schoolId)
    }

}
