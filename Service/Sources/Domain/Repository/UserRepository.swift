import Foundation

import RxSwift

protocol UserRepository {
    func changePassword(accountID: String, phoneNumber: String, authCode: String, newPassword: String) -> Single<Void>
    func fetchProfile(userID: Int) -> Observable<UserProfile>
    func fetchMyProfile() -> Observable<UserProfile>
    func fetchBadges(userID: Int) -> Observable<[Badge]>
    func setMainBadge(badgeId: Int) -> Single<Void>
    func changeProfile(name: String, profileImageUrlString: String, birthday: String, sex: Sex) -> Single<Void>
    func patchHealth(height: Float, weight: Int) -> Single<Void>
    func joinClass(groupId: Int) -> Single<Void>
    func setSchoolInformation(schoolId: String) -> Single<Void>
}
