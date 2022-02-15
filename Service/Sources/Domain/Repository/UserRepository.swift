import Foundation

import RxSwift

protocol UserRepository {
    func changePassword(accountID: String, phoneNumber: String, authCode: String, newPassword: String) -> Single<Void>
    func fetchProfile(userID: Int) -> Observable<UserProfile>
    func fetchMyProfile() -> Observable<UserProfile>
    func changeProfile(name: String, profileImageUrlString: String, sex: Sex) -> Single<Void>
    func writeHealth(height: Float, weight: Int) -> Single<Void>
    func joinClass(sectionId: Int, classCode: String, num: Int) -> Single<Void>
    func setSchoolInformation(schoolId: Int) -> Single<Void>
    func changeGoalWalkCount(goalWalkCount: Int) -> Single<Void>
}
