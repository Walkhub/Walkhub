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
        schoolId: Int
    ) -> Completable {
        return request(.changeProfile(
            name: name,
            profileImageUrlString: profileImageUrlString,
            schoolId: schoolId
        )).asCompletable()
    }

    func setHealthInformation(
        height: Float,
        weight: Int,
        sex: Sex
    ) -> Completable {
        return request(.setHealthInformation(
            height: height,
            weight: weight,
            sex: sex
        )).asCompletable()
    }

    func joinClass(
        sectionId: Int,
        classCode: String,
        num: Int
    ) -> Single<Void> {
        return request(.joinClass(
            sectionId: sectionId,
            classCode: classCode,
            num: num
        )).map { _ in () }
    }

    func changeGoalWalkCount(goalWalkCount: Int) -> Single<Void> {
        return request(.changeGoalWalkCount(goalWalkCount: goalWalkCount))
            .map { _ in () }
    }

    func fetchUserHeaelth() -> Single<UserHealth> {
        return request(.fetchHealthInformation)
            .map(UserHealthDTO.self)
            .map { $0.toDomain() }
    }
}
