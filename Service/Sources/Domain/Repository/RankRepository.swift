import Foundation

import RxSwift

protocol RankRepository {
    func fetchSchoolRank() -> Observable<MySchool>
    func searchSchool(name: String?, dateType: DateType) -> Observable<[School]>
    func fetchMySchoolUserRank(scope: GroupScope, dateType: DateType) -> Observable<UserRank>
    func fetchAnotherSchoolUserRank(schoolId: Int, dateType: DateType) -> Observable<[RankedUser]>
    func searchUser(name: String, dateType: DateType, schoolId: Int) -> Observable<[User]>
}
