import Foundation

import RxSwift

protocol UserRepository {
    func changePassword(accountID: String, phoneNumber: String, authCode: String, newPassword: String) -> Single<Void>
    func profileInquiry(userID: Int) -> Single<UserProfileDTO>
    func myPageInquiry() -> Single<UserProfileDTO>
    func badgeInquiry(userID: Int) -> Single<BadgeListDTO>
    func mainBadgeSet(badgeID: Int) -> Single<Void>
    func changeProfile(name: String, profileImageUrlString: String, birthday: String, sex: String) -> Single<Void>
    func findID(phoneNumber: String) -> Single<FindUserIdDTO>
    func writeHealth(height: Float, weight: Int) -> Single<Void>
    func joinClass(agencyCode: String, grade: Int, classNum: Int) -> Single<Void>
    func changeSchoolInformation(agencyCode: String) -> Single<Void>
}
