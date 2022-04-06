import Foundation

import RxSwift

protocol UserRepository {
    func changePassword(accountID: String, phoneNumber: String, authCode: String, newPassword: String) -> Single<Void>
    func fetchProfile(userID: Int) -> Observable<UserProfile>
    func fetchMyProfile() -> Observable<UserProfile>
    func changeProfile(name: String, profileImageUrlString: String, schoolId: Int) -> Completable
    func setHealthInformation(height: Float, weight: Int, sex: Sex) -> Completable
    func joinClass(sectionId: Int, classCode: String, num: Int) -> Single<Void>
    func changeGoalWalkCount(goalWalkCount: Int) -> Single<Void>
    func fetchUserHealth() -> Single<UserHealth>
}
