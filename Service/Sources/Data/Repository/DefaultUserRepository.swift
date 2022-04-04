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

    func changeProfile(
        name: String,
        profileImageUrlString: String,
        sex: Sex
    ) -> Single<Void> {
        return remoteUserDataSource.changeProfile(
            name: name,
            profileImageUrlString: profileImageUrlString,
            sex: sex
        )
    }
    func setHealthInformation(height: Float, weight: Int, sex: Sex) -> Completable {
        return remoteUserDataSource.setHealthInformation(height: height, weight: weight, sex: sex)
    }

    func joinClass(
        sectionId schoolId: Int,
        classCode grade: String,
        num classNum: Int
    ) -> Single<Void> {
        return remoteUserDataSource.joinClass(
            sectionId: schoolId,
            classCode: grade,
            num: classNum
        )
    }

    func setSchoolInformation(schoolId: Int) -> Single<Void> {
        return remoteUserDataSource.setSchoolInformation(schoolId: schoolId)
    }

    func changeGoalWalkCount(goalWalkCount: Int) -> Single<Void> {
        return remoteUserDataSource.changeGoalWalkCount(goalWalkCount: goalWalkCount)
    }

    func checkClassCode(code: String) -> Completable {
        return remoteUserDataSource.checkClassCode(code: code)
    }
}
