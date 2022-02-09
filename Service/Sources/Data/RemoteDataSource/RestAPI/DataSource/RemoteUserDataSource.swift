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

    func fetchBadges(userID: Int) -> Single<[Badge]> {
        return request(.fetchBadges(userID: userID))
            .map(BadgeListDTO.self)
            .map { $0.toDomain() }
    }

    func setMainBadge(badgeId: Int) -> Single<Void> {
        return request(.setMainBadge(badgeId: badgeId))
            .map { _ in () }
    }

    func changeProfile(
        name: String,
        profileImageUrlString: String,
        birthday: String,
        sex: Sex
    ) -> Single<Void> {
        return request(.changeProfile(
            name: name,
            profileImageUrlString: profileImageUrlString,
            birthday: birthday,
            sex: sex
        )).map { _ in () }
    }

    func writeHealth(
        height: Float,
        weight: Int
    ) -> Single<Void> {
        return request(.setHealthInformation(
            height: height,
            weight: weight
        )).map { _ in () }
    }

    func joinClass(groupId: Int) -> Single<Void> {
        return request(.joinClass(groupId: groupId))
            .map { _ in () }
    }

    func setSchoolInformation(schoolId: String) -> Single<Void> {
        return request(.setSchoolInformation(schoolId: schoolId))
            .map { _ in () }
    }

}
