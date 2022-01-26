import Foundation

import Moya
import RxSwift

final class RemoteUserDataSource: RemoteBaseDataSource<UserAPI> {

    static let shared = RemoteUserDataSource()

    private override init() { }

    func changePassword(
        accountID: String,
        phoneNumber: String,
        authCode: String,
        newPassword: String
    ) -> Single<Response> {
        return request(.changePassword(
            accountID: accountID,
            phoneNumber: phoneNumber,
            authCode: authCode,
            newPassword: newPassword
        ))
    }

    func fetchProfile(userID: Int) -> Single<Response> {
        return request(.fetchProfile(userID: userID))
    }

    func fetchMyInformation() -> Single<Response> {
        return request(.fetchMyInformation)
    }

    func fetchBadges(userID: Int) -> Single<Response> {
        return request(.fetchBadges(userID: userID))
    }

    func mainBadgeSet(badgeID: Int) -> Single<Response> {
        return request(.setMainBadge(badgeID: badgeID))
    }

    func changeProfile(
        name: String,
        profileImageUrlString: String,
        birthday: String,
        sex: String
    ) -> Single<Response> {
        return request(.changeProfile(
            name: name,
            profileImageUrlString: profileImageUrlString,
            birthday: birthday,
            sex: sex
        ))
    }

    func writeHealth(
        height: Float,
        weight: Int
    ) -> Single<Response> {
        return request(.setHealthInformation(
            height: height,
            weight: weight
        ))
    }

    func joinClass(
        agencyCode: String,
        grade: Int,
        classNum: Int
    ) -> Single<Response> {
        return request(.joinClass(
            agencyCode: agencyCode,
            grade: grade,
            classNum: classNum
        ))
    }

    func setSchoolInformation(agencyCode: String) -> Single<Response> {
        return request(.setSchoolInformation(agencyCode: agencyCode))
    }

}
