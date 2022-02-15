import Foundation

import RxSwift

class DefaultUserRepository: UserRepository {

    func changeProfile(
        name: String,
        profileImageUrlString: String,
        sex: Sex
    ) -> Single<Void> {
        return RemoteUserDataSource.shared.changeProfile(
            name: name,
            profileImageUrlString: profileImageUrlString,
            sex: sex
        )
    }

    func setSchoolInformation(schoolId: Int) -> Single<Void> {
        return RemoteUserDataSource.shared.setSchoolInformation(schoolId: schoolId)
    }

    func changeGoalWalkCount(goalWalkCount: Int) -> Single<Void> {
        return RemoteUserDataSource.shared.changeGoalWalkCount(goalWalkCount: goalWalkCount)
    }

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

    func writeHealth(height: Float, weight: Int) -> Single<Void> {
        return RemoteUserDataSource.shared.writeHealth(height: height, weight: weight)
    }

    func joinClass(
        sectionId schoolId: Int,
        classCode grade: String,
        num classNum: Int
    ) -> Single<Void> {
        return RemoteUserDataSource.shared.joinClass(
            sectionId: schoolId,
            classCode: grade,
            num: classNum
        )
    }
}
