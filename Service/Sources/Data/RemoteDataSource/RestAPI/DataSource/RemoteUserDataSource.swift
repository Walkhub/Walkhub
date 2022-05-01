import Foundation

import Moya
import RxSwift

final class RemoteUserDataSource: RestApiRemoteDataSource<UserAPI> {

    static let shared = RemoteUserDataSource()

    private override init() { }

    func checkPassword(currentPw: String) -> Completable {
        return request(.checkPassword(currentPw: currentPw))
            .asCompletable()
    }

    func changePassword(
        password: String,
        newPassword: String
    ) -> Completable {
        return request(.changePassword(
            password: password,
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
    func checkClassCode(code: String) -> Completable {
        return request(.checkClassCode(code: code))
            .asCompletable()
    }
}
