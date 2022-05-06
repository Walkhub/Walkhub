import Foundation

import RxSwift

class DefaultUserRepository: UserRepository {

    private let remoteUserDataSource = RemoteUserDataSource.shared
    private let localUserDataSource = LocalUserDataSource.shared

    func checkPassword(currentPw: String) -> Completable {
        return remoteUserDataSource.checkPassword(currentPw: currentPw)
            .do(onError: {
                print($0
                )
            })
    }

    func changePassword(
        password: String,
        newPassword: String
    ) -> Completable {
        return remoteUserDataSource.changePassword(
            password: password,
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
        schoolId: Int
    ) -> Completable {
        return remoteUserDataSource.changeProfile(
            name: name,
            profileImageUrlString: profileImageUrlString,
            schoolId: schoolId
        )
    }
    func setHealthInformation(
        height: Double?,
        weight: Int?,
        sex: Sex
    ) -> Completable {
        return remoteUserDataSource.setHealthInformation(
            height: height ?? 0.0,
            weight: weight ?? 0,
            sex: sex
        )
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

    func changeGoalWalkCount(goalWalkCount: Int) -> Single<Void> {
        return remoteUserDataSource.changeGoalWalkCount(goalWalkCount: goalWalkCount)
    }

    func fetchUserHealth() -> Single<UserHealth> {
        return remoteUserDataSource.fetchHealthInfo()
    }

    func checkClassCode(code: String) -> Completable {
        return remoteUserDataSource.checkClassCode(code: code)
    }

    func fetchAccountInfo() -> Observable<AccountInfo> {
        return remoteUserDataSource.fetchAccountInfo()
            .asObservable()
    }
}
