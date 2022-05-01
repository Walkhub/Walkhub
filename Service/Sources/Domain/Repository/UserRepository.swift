import Foundation

import RxSwift

protocol UserRepository {
    func checkPassword(currentPw: String) -> Completable
    func changePassword(accountID: String, phoneNumber: String, authCode: String, newPassword: String) -> Single<Void>
    func fetchProfile(userID: Int) -> Observable<UserProfile>
    func fetchMyProfile() -> Observable<UserProfile>
<<<<<<< HEAD
    func changeProfile(name: String, profileImageUrlString: String, schoolId: Int) -> Completable
=======
    func changeProfile(name: String, profileImageUrlString: String, sex: Sex) -> Single<Void>
>>>>>>> 9bacb28d8314fbfdc663b5be5d065399bcbd3933
    func setHealthInformation(height: Double?, weight: Int?, sex: Sex) -> Completable
    func joinClass(sectionId: Int, classCode: String, num: Int) -> Single<Void>
    func changeGoalWalkCount(goalWalkCount: Int) -> Single<Void>
<<<<<<< HEAD
    func fetchUserHealth() -> Single<UserHealth>
=======
    func checkClassCode(code: String) -> Completable
>>>>>>> 9bacb28d8314fbfdc663b5be5d065399bcbd3933
}
