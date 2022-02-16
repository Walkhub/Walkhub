import Foundation

import RxSwift

protocol RankRepository {
    func fetchSchoolRank(dateType: DateType) -> Observable<SchoolRank>
    func searchSchool(name: String, dateType: DateType) -> Single<[SearchSchoolRank]>
    func fetchUserSchoolRank(scope: Scope, dateType: DateType) -> Observable<UserRank>
    func fetchUserRank(schoolId: Int, dateType: DateType) -> Single<[User]>
    func searchUser(schoolId: Int, name: String, dateType: DateType) -> Single<[User]>
}
