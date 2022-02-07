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

    func setMainBadge(badgeID: Int) -> Single<Void> {
        return request(.setMainBadge(badgeID: badgeID))
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

    func joinClass(
        agencyCode: String,
        grade: Int,
        classNum: Int
    ) -> Single<Void> {
        return request(.joinClass(
            agencyCode: agencyCode,
            grade: grade,
            classNum: classNum
        )).map { _ in () }
    }

    func setSchoolInformation(agencyCode: String) -> Single<Void> {
        return request(.setSchoolInformation(agencyCode: agencyCode))
            .map { _ in () }
    }

}
