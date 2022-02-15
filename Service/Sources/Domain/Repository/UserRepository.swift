import Foundation

import RxSwift

protocol UserRepository {
    func changePassword(accountID: String, phoneNumber: String, authCode: String, newPassword: String) -> Completable
    func fetchProfile(userID: Int) -> Observable<UserProfile>
    func fetchMyProfile() -> Observable<UserProfile>
    func changeProfile(name: String, profileImageUrl: URL, sex: Sex) -> Completable
    func patchHealthInformation(height: Float, weight: Int) -> Completable
    func joinClass(classCode: String, num: Int) -> Completable
    func setSchoolInformation(schoolId: String) -> Completable
    func changeGoalWalkCount(goalWalkCount: Int) -> Completable
}
