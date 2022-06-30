import Foundation

import Moya
import RxSwift

final class RemoteUserDataSource: RestApiRemoteDataSource<UserAPI> {

    static let shared = RemoteUserDataSource()

    private override init() { }

    func changePassword(
        accountID: String,
        phoneNumber: String,
        authCode: String,
        newPassword: String
    ) -> Single<Void> {
        return request(.changePassword(
            accountID: accountID,
            phoneNumber: phoneNumber,
            authCode: authCode,
            newPassword: newPassword
        )).map { _ in () }
    }

    func fetchProfile(userID: Int) -> Single<UserProfile> {
        return request(.fetchProfile(userID: userID))
            .map(UserProfileDTO.self)
            .map { $0.toDomain() }
    }

    func fetchMyProfile() -> Single<UserProfile> {
        return request(.fetchMyProfile)
            .map(UserProfileDTO.self)
            .map { $0.toDomain() }
    }

    func changeProfile(
        name: String,
        profileImageUrlString: String,
        sex: Sex
    ) -> Single<Void> {
        return request(.changeProfile(
            name: name,
            profileImageUrlString: profileImageUrlString,
            sex: sex
        )).map { _ in () }
    }

    func setHealthInformation(
        height: Double?,
        weight: Int?,
        sex: Sex
    ) -> Completable {
        return request(.setHealthInformation(
            height: height,
            weight: weight,
            sex: sex
        )).asCompletable()
    }

    func joinClass(
        classCode: String,
        num: Int
    ) -> Completable {
        return request(.joinClass(
            classCode: classCode,
            num: num
        )).asCompletable()
    }

    func setSchoolInformation(schoolId: Int) -> Single<Void> {
        return request(.setSchoolInformation(schoolId: schoolId))
            .map { _ in () }
    }

    func changeGoalWalkCount(goalWalkCount: Int) -> Single<Void> {
        return request(.changeGoalWalkCount(goalWalkCount: goalWalkCount))
            .map { _ in () }
    }

    func checkClassCode(code: String) -> Completable {
        return request(.checkClassCode(code: code))
            .asCompletable()
    }
}
