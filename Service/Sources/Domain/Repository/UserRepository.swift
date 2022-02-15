import Foundation

import RxSwift

protocol UserRepository {
    func changePassword(accountID: String, phoneNumber: String, authCode: String, newPassword: String) -> Completable
    func fetchProfile(userID: Int) -> Observable<UserProfile>
    func fetchMyProfile() -> Observable<UserProfile>
    func fetchBadges(userID: Int) -> Observable<[Badge]>
    func setMainBadge(badgeId: Int) -> Completable
    func changeProfile(name: String, profileImageUrl: URL, sex: Sex) -> Completable
    func patchHealthInformation(height: Float, weight: Int) -> Completable
    func joinClass(groupId: Int) -> Completable
    func setSchoolInformation(schoolId: String) -> Completable
}
