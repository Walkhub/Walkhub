import Foundation

import RxSwift

protocol UserRepository {
    func changePassword(accountID: String, phoneNumber: String, authCode: String, newPassword: String) -> Completable
    func fetchProfile(userID: Int) -> Observable<UserProfile>
    func fetchMyProfile() -> Observable<UserProfile>
    func fetchBadges(userID: Int) -> Observable<[Badge]>
    func setMainBadge(badgeId: Int) -> Completable
    func changeProfile(name: String, profileImageUrlString: String, birthday: String, sex: Sex) -> Completable
    func patchHealth(height: Float, weight: Int) -> Completable
    func joinClass(groupId: Int) -> Completable
    func setSchoolInformation(schoolId: String) -> Completable
}
