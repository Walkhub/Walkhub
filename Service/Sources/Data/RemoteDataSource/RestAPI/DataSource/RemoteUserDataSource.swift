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
    ) -> Completable {
        return request(.changePassword(
            accountID: accountID,
            phoneNumber: phoneNumber,
            authCode: authCode,
            newPassword: newPassword
        )).asCompletable()
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
        profileImageUrl: URL,
        sex: Sex
    ) -> Completable {
        return request(.changeProfile(
            name: name,
            profileImageUrl: profileImageUrl,
            sex: sex
        )).asCompletable()
    }

    func patchHealthInformation(
        height: Float,
        weight: Int
    ) -> Completable {
        return request(.patchHealthInformation(
            height: height,
            weight: weight
        )).asCompletable()
    }

    func joinClass(classCode: Int, number: Int) -> Completable {
        return request(.joinClass(classCode: classCode, number: number))
            .asCompletable()
    }

    func setSchoolInformation(schoolId: String) -> Completable {
        return request(.patchSchoolInformation(schoolId: schoolId))
            .asCompletable()
    }

    func changeGoalWalkCount(goalWalkCount: Int) -> Completable {
        return request(.changeGoalWalkCount(goalWalkCount: goalWalkCount))
            .asCompletable()
    }

}
