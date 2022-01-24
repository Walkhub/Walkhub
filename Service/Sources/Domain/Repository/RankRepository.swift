import Foundation

import RxSwift

protocol RankRepository {
    func fetchSchoolRank(dateType: String) -> Observable<SchoolRank>
    func searchSchool(name: String) -> Single<[School]>
    func fetchUserRank(scope: String, dateTypa: String, sort: String, agencyCode: String) -> Observable<UserRank>
    func searchUser(name: String, scope: String, agencyCode: String, grade: Int, classNum: Int) -> Single<[User]>
}
