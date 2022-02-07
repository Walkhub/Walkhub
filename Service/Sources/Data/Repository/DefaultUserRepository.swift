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

    func setMainBadge(badgeID: Int) -> Single<Void> {
        return RemoteUserDataSource.shared.setMainBadge(badgeID: badgeID)
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

    func writeHealth(height: Float, weight: Int) -> Single<Void> {
        return RemoteUserDataSource.shared.writeHealth(height: height, weight: weight)
    }

    func joinClass(
        agencyCode: String,
        grade: Int,
        classNum: Int
    ) -> Single<Void> {
        return RemoteUserDataSource.shared.joinClass(
            agencyCode: agencyCode,
            grade: grade,
            classNum: classNum
        )
    }

    func setSchoolInformation(agencyCode: String) -> Single<Void> {
        return RemoteUserDataSource.shared.setSchoolInformation(agencyCode: agencyCode)
    }

}
