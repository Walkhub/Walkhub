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

    func fetchBadges(userID: Int) -> Single<[Badge]> {
        return request(.fetchBadges(userID: userID))
            .map(BadgeListDTO.self)
            .map { $0.toDomain() }
    }

    func setMainBadge(badgeId: Int) -> Completable {
        return request(.setMainBadge(badgeId: badgeId))
            .asCompletable()
    }

    func changeProfile(
        name: String,
        profileImageUrlString: String,
        birthday: String,
        sex: Sex
    ) -> Completable {
        return request(.changeProfile(
            name: name,
            profileImageUrlString: profileImageUrlString,
            birthday: birthday,
            sex: sex
        )).asCompletable()
    }

    func patchHealth(
        height: Float,
        weight: Int
    ) -> Completable {
        return request(.setHealthInformation(
            height: height,
            weight: weight
        )).asCompletable()
    }

    func joinClass(groupId: Int) -> Completable {
        return request(.joinClass(groupId: groupId))
            .asCompletable()
    }

    func setSchoolInformation(schoolId: String) -> Completable {
        return request(.setSchoolInformation(schoolId: schoolId))
            .asCompletable()
    }

}
