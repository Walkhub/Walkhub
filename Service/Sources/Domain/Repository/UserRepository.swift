import Foundation

import RxSwift

protocol UserRepository {
    func checkPassword(currentPw: String) -> Completable
    func changePassword(password: String, newPassword: String) -> Completable
    func fetchProfile(userID: Int) -> Observable<UserProfile>
    func fetchMyProfile() -> Observable<UserProfile>
    func changeProfile(name: String, profileImageUrlString: String, schoolId: Int) -> Completable
    func setHealthInformation(height: Double?, weight: Int?, sex: Sex) -> Completable
<<<<<<< HEAD
    func joinClass(sectionId: Int, classCode: String, num: Int) -> Single<Void>
=======
    func joinClass(classCode: String, num: Int) -> Completable
    func setSchoolInformation(schoolId: Int) -> Single<Void>
>>>>>>> ff0db01b3db379d9c73b7b18b0e6b29b58ed9f34
    func changeGoalWalkCount(goalWalkCount: Int) -> Single<Void>
    func fetchUserHealth() -> Single<UserHealth>
    func checkClassCode(code: String) -> Completable
    func fetchAccountInfo() -> Observable<AccountInfo>
}
