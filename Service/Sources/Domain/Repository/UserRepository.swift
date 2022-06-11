import Foundation

import RxSwift

protocol UserRepository {
    func checkPassword(currentPw: String) -> Completable
    func changePassword(password: String, newPassword: String) -> Completable
    func fetchProfile(userID: Int) -> Observable<UserProfile>
    func fetchMyProfile() -> Observable<UserProfile>
    func changeProfile(name: String, profileImageUrlString: String, schoolId: Int) -> Completable
    func setHealthInformation(height: Double?, weight: Int?, sex: Sex) -> Completable
    func joinClass(classCode: String, num: Int) -> Completable
    func changeGoalWalkCount(goalWalkCount: Int) -> Single<Void>
    func fetchUserHealth() -> Single<UserHealth>
    func checkClassCode(code: String) -> Completable
    func fetchAccountInfo() -> Observable<AccountInfo>
}
