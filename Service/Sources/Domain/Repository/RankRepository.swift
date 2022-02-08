import Foundation

import RxSwift

protocol RankRepository {
    func fetchSchoolRank(dateType: DateType) -> Observable<SchoolRank>
    func searchSchool(name: String) -> Single<[School]>
    func fetchUserSchoolRank(scope: Scope, dateType: DateType) -> Observable<UserRank>
    func fetchUserRank(scope: Scope, dateTypa: DateType, schoolId: String) -> Single<[User]>
    func searchUser(name: String, scope: Scope, schoolId: String, grade: Int, classNum: Int) -> Single<[User]>
}
