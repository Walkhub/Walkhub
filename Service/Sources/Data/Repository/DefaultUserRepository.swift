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

    func joinClass(classCode: String, number: Int) -> Completable {
        return remoteUserDataSource.joinClass(classCode: classCode, number: number)
    }

    func setSchoolInformation(schoolId: String) -> Completable {
        return remoteUserDataSource.setSchoolInformation(schoolId: schoolId)
    }

    func changeGoalWalkCount(goalWalkCount: Int) -> Completable {
        return remoteUserDataSource.changeGoalWalkCount(goalWalkCount: goalWalkCount)
    }

}
