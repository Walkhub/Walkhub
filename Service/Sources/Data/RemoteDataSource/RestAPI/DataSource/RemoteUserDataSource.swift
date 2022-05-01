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
<<<<<<< HEAD
        height: Double,
        weight: Int,
=======
        height: Double?,
        weight: Int?,
>>>>>>> 9bacb28d8314fbfdc663b5be5d065399bcbd3933
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

<<<<<<< HEAD
    func fetchUserHeaelth() -> Single<UserHealth> {
        return request(.fetchHealthInformation)
            .map(UserHealthDTO.self)
            .map { $0.toDomain() }
=======
    func checkClassCode(code: String) -> Completable {
        return request(.checkClassCode(code: code))
            .asCompletable()
>>>>>>> 9bacb28d8314fbfdc663b5be5d065399bcbd3933
    }
}
