import Foundation

import RxSwift

protocol RankRepository {
    func fetchSchoolRank() -> Observable<MySchool>
    func searchSchool(name: String?, dateType: DateType) -> Observable<[School]>
    func fetchUserSchoolRank(scope: GroupScope, dateType: DateType) -> Observable<UserRank>
    func fetchUserRank(schoolId: Int, dateType: DateType) -> Single<[RankedUser]>
    func searchUser(schoolId: Int, name: String, dateType: DateType) -> Single<[User]>
}
